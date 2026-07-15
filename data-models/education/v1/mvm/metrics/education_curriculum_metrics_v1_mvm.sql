-- Metric views for domain: curriculum | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_academic_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for academic program portfolio health, covering graduation outcomes, GPA thresholds, accreditation posture, and program mix across delivery modalities and degree levels."
  source: "`education_ecm`.`curriculum`.`academic_program`"
  dimensions:
    - name: "degree_level"
      expr: degree_level
      comment: "Degree level of the program (e.g., Bachelor, Master, Doctoral) — primary slice for portfolio analysis."
    - name: "degree_designation"
      expr: degree_designation
      comment: "Specific degree designation (e.g., BS, MBA, PhD) for granular program classification."
    - name: "delivery_modality"
      expr: delivery_modality
      comment: "Instructional delivery mode (e.g., On-Campus, Online, Hybrid) — key for strategic enrollment planning."
    - name: "program_status"
      expr: program_status
      comment: "Operational status of the program (e.g., Active, Suspended, Discontinued) — used to filter live portfolio."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation standing of the program — critical for compliance and enrollment eligibility."
    - name: "is_stem_designated"
      expr: is_stem_designated
      comment: "Indicates whether the program carries STEM designation — affects OPT eligibility and federal reporting."
    - name: "title_iv_eligible"
      expr: title_iv_eligible
      comment: "Whether the program qualifies for Title IV federal financial aid — directly impacts enrollment revenue."
    - name: "catalog_year"
      expr: catalog_year
      comment: "Academic catalog year governing the program requirements — used for cohort and trend analysis."
    - name: "program_format"
      expr: program_format
      comment: "Structural format of the program (e.g., Traditional, Accelerated, Cohort) — informs scheduling and resource planning."
    - name: "admission_type"
      expr: admission_type
      comment: "Admission pathway type (e.g., Open, Selective, Competitive) — used to segment program demand analysis."
    - name: "gainful_employment_applicable"
      expr: gainful_employment_applicable
      comment: "Whether the program is subject to gainful employment regulations — triggers additional federal reporting obligations."
    - name: "ipeds_award_level"
      expr: ipeds_award_level
      comment: "IPEDS award level classification — required for federal completions reporting."
  measures:
    - name: "total_active_programs"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN academic_program_id END)
      comment: "Count of currently active academic programs — baseline portfolio size metric for executive dashboards."
    - name: "avg_six_year_graduation_rate"
      expr: ROUND(AVG(CAST(six_year_graduation_rate AS DOUBLE)), 2)
      comment: "Average six-year graduation rate across programs — primary student success and accreditation outcome KPI."
    - name: "avg_dfw_rate"
      expr: ROUND(AVG(CAST(dfw_rate AS DOUBLE)), 2)
      comment: "Average DFW (Drop/Fail/Withdraw) rate across programs — signals academic risk and curriculum quality issues."
    - name: "avg_min_gpa_required"
      expr: ROUND(AVG(CAST(min_gpa_required AS DOUBLE)), 2)
      comment: "Average minimum GPA requirement across programs — reflects academic selectivity and admission standards."
    - name: "stem_designated_program_count"
      expr: COUNT(CASE WHEN is_stem_designated = TRUE THEN academic_program_id END)
      comment: "Number of STEM-designated programs — strategic metric for research positioning and international student recruitment."
    - name: "title_iv_eligible_program_count"
      expr: COUNT(CASE WHEN title_iv_eligible = TRUE THEN academic_program_id END)
      comment: "Count of Title IV eligible programs — directly tied to federal financial aid revenue exposure."
    - name: "online_program_count"
      expr: COUNT(CASE WHEN delivery_modality = 'Online' THEN academic_program_id END)
      comment: "Number of fully online programs — tracks digital transformation of the academic portfolio."
    - name: "programs_pending_accreditation_review"
      expr: COUNT(CASE WHEN next_accreditation_review_date <= CURRENT_DATE() THEN academic_program_id END)
      comment: "Programs with an overdue or imminent accreditation review — compliance risk indicator for leadership."
    - name: "pct_programs_stem_designated"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stem_designated = TRUE THEN academic_program_id END) / NULLIF(COUNT(academic_program_id), 0), 2)
      comment: "Percentage of programs with STEM designation — portfolio diversification and strategic positioning metric."
    - name: "pct_programs_title_iv_eligible"
      expr: ROUND(100.0 * COUNT(CASE WHEN title_iv_eligible = TRUE THEN academic_program_id END) / NULLIF(COUNT(academic_program_id), 0), 2)
      comment: "Percentage of programs eligible for Title IV aid — financial aid revenue coverage ratio for CFO reporting."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Course catalog quality and composition KPIs covering credit load, OER adoption, STEM coverage, cross-listing, and curriculum delivery mix — used by Provost and Deans for curriculum governance."
  source: "`education_ecm`.`curriculum`.`course`"
  dimensions:
    - name: "course_level"
      expr: course_level
      comment: "Academic level of the course (e.g., 100, 200, 300, 400, Graduate) — used to analyze curriculum depth and progression."
    - name: "course_type"
      expr: course_type
      comment: "Classification of the course type (e.g., Lecture, Lab, Seminar, Internship) — informs resource and scheduling decisions."
    - name: "delivery_modality"
      expr: delivery_modality
      comment: "Instructional delivery mode for the course — tracks online vs. in-person curriculum composition."
    - name: "course_status"
      expr: course_status
      comment: "Current lifecycle status of the course (e.g., Active, Inactive, Pending) — filters operational catalog."
    - name: "subject_code"
      expr: subject_code
      comment: "Academic subject/discipline code — primary grouping for departmental curriculum analysis."
    - name: "gen_ed_category"
      expr: gen_ed_category
      comment: "General education category the course satisfies — used for gen-ed requirement coverage analysis."
    - name: "grading_basis"
      expr: grading_basis
      comment: "Grading method applied to the course (e.g., Letter Grade, Pass/Fail, Satisfactory/Unsatisfactory)."
    - name: "stem_designated"
      expr: stem_designated
      comment: "Whether the course carries STEM designation — relevant for program-level STEM compliance tracking."
    - name: "oer_designated"
      expr: oer_designated
      comment: "Whether the course uses Open Educational Resources — tracks cost-reduction and affordability initiatives."
    - name: "writing_intensive"
      expr: writing_intensive
      comment: "Indicates if the course meets writing-intensive requirements — used for gen-ed and accreditation mapping."
    - name: "honors_eligible"
      expr: honors_eligible
      comment: "Whether the course is available in an honors section — tracks honors program curriculum breadth."
    - name: "catalog_year_start"
      expr: catalog_year_start
      comment: "First catalog year in which the course was offered — used for longitudinal curriculum trend analysis."
  measures:
    - name: "total_active_courses"
      expr: COUNT(CASE WHEN course_status = 'Active' THEN course_id END)
      comment: "Total number of active courses in the catalog — baseline curriculum portfolio size metric."
    - name: "avg_credit_hours"
      expr: ROUND(AVG(CAST(credit_hours AS DOUBLE)), 2)
      comment: "Average credit hours per course — informs workload planning and degree completion pathway analysis."
    - name: "total_credit_hours_offered"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total credit hours across all active courses — measures curriculum volume for capacity and revenue planning."
    - name: "avg_lecture_hours"
      expr: ROUND(AVG(CAST(lecture_hours AS DOUBLE)), 2)
      comment: "Average lecture contact hours per course — used to assess instructional intensity and faculty workload."
    - name: "avg_lab_hours"
      expr: ROUND(AVG(CAST(lab_hours AS DOUBLE)), 2)
      comment: "Average lab contact hours per course — informs facility and equipment resource planning."
    - name: "oer_designated_course_count"
      expr: COUNT(CASE WHEN oer_designated = TRUE THEN course_id END)
      comment: "Number of courses using Open Educational Resources — tracks student cost-reduction program progress."
    - name: "pct_oer_designated"
      expr: ROUND(100.0 * COUNT(CASE WHEN oer_designated = TRUE THEN course_id END) / NULLIF(COUNT(CASE WHEN course_status = 'Active' THEN course_id END), 0), 2)
      comment: "Percentage of active courses with OER designation — executive KPI for affordability and textbook cost initiatives."
    - name: "cross_listed_course_count"
      expr: COUNT(CASE WHEN cross_listed_flag = TRUE THEN course_id END)
      comment: "Number of cross-listed courses — indicates curriculum efficiency and interdisciplinary collaboration."
    - name: "stem_designated_course_count"
      expr: COUNT(CASE WHEN stem_designated = TRUE THEN course_id END)
      comment: "Count of STEM-designated courses — supports STEM program compliance and federal reporting."
    - name: "avg_max_repeat_hours"
      expr: ROUND(AVG(CAST(max_repeat_hours AS DOUBLE)), 2)
      comment: "Average maximum repeatable credit hours per course — informs degree audit and financial aid repeat-course policies."
    - name: "writing_intensive_course_count"
      expr: COUNT(CASE WHEN writing_intensive = TRUE THEN course_id END)
      comment: "Number of writing-intensive courses — tracks gen-ed writing requirement coverage across the curriculum."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_section`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Course section scheduling and enrollment KPIs — used by Registrar and Deans to monitor section utilization, delivery mix, and instructional capacity each term."
  source: "`education_ecm`.`curriculum`.`section`"
  dimensions:
    - name: "delivery_modality"
      expr: delivery_modality
      comment: "Delivery mode of the section (e.g., In-Person, Online, Hybrid) — primary slice for enrollment and capacity analysis."
    - name: "meeting_pattern"
      expr: meeting_pattern
      comment: "Days and times the section meets — used for scheduling conflict analysis and facility utilization."
    - name: "term_id"
      expr: term_id
      comment: "Foreign key to the academic term — used to trend section counts and enrollment across semesters."
  measures:
    - name: "total_sections_offered"
      expr: COUNT(section_id)
      comment: "Total number of course sections offered — baseline instructional capacity metric for the Registrar."
    - name: "distinct_courses_scheduled"
      expr: COUNT(DISTINCT course_id)
      comment: "Number of unique courses with at least one scheduled section — measures active curriculum utilization."
    - name: "distinct_instructors_assigned"
      expr: COUNT(DISTINCT instructor_id)
      comment: "Number of unique instructors assigned to sections — tracks faculty deployment and teaching load distribution."
    - name: "online_section_count"
      expr: COUNT(CASE WHEN delivery_modality = 'Online' THEN section_id END)
      comment: "Number of online sections — tracks digital delivery capacity and online program growth."
    - name: "pct_online_sections"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_modality = 'Online' THEN section_id END) / NULLIF(COUNT(section_id), 0), 2)
      comment: "Percentage of sections delivered online — strategic KPI for digital transformation progress reporting."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_teaching_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty teaching workload and instructional assignment KPIs — used by Deans and HR to monitor credit hour allocation, workload equity, and primary instructor coverage."
  source: "`education_ecm`.`curriculum`.`teaching_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the teaching assignment (e.g., Active, Cancelled, Pending) — filters operational assignments."
    - name: "instructional_method"
      expr: instructional_method
      comment: "Method of instruction used (e.g., Lecture, Lab, Online Asynchronous) — used for workload and modality analysis."
    - name: "primary_instructor_flag"
      expr: primary_instructor_flag
      comment: "Indicates whether the instructor is the primary instructor of record — used to isolate accountability metrics."
  measures:
    - name: "total_teaching_assignments"
      expr: COUNT(teaching_assignment_id)
      comment: "Total number of teaching assignments — baseline faculty deployment metric."
    - name: "distinct_instructors_teaching"
      expr: COUNT(DISTINCT instructor_id)
      comment: "Number of unique instructors with active teaching assignments — measures instructional workforce utilization."
    - name: "total_credit_hour_allocation"
      expr: SUM(CAST(credit_hour_allocation AS DOUBLE))
      comment: "Total credit hours allocated across all teaching assignments — primary faculty workload volume metric."
    - name: "avg_credit_hour_allocation_per_assignment"
      expr: ROUND(AVG(CAST(credit_hour_allocation AS DOUBLE)), 2)
      comment: "Average credit hours per teaching assignment — used to assess workload equity and identify overloaded faculty."
    - name: "avg_workload_percentage"
      expr: ROUND(AVG(CAST(workload_percentage AS DOUBLE)), 2)
      comment: "Average workload percentage per assignment — tracks faculty effort distribution and contract compliance."
    - name: "primary_instructor_assignment_count"
      expr: COUNT(CASE WHEN primary_instructor_flag = TRUE THEN teaching_assignment_id END)
      comment: "Number of assignments where the instructor is the primary instructor of record — ensures accountability coverage."
    - name: "pct_primary_instructor_coverage"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_instructor_flag = TRUE THEN teaching_assignment_id END) / NULLIF(COUNT(teaching_assignment_id), 0), 2)
      comment: "Percentage of sections with a designated primary instructor — operational quality metric for the Registrar."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_plo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Learning Outcome (PLO) governance KPIs — used by Provost, accreditation officers, and assessment coordinators to track outcome coverage, accreditation alignment, and assessment cycle health."
  source: "`education_ecm`.`curriculum`.`plo`"
  dimensions:
    - name: "degree_level"
      expr: degree_level
      comment: "Degree level associated with the PLO — used to segment outcome analysis by program tier."
    - name: "outcome_status"
      expr: outcome_status
      comment: "Current status of the PLO (e.g., Active, Retired, Under Review) — filters operational outcomes."
    - name: "outcome_category"
      expr: outcome_category
      comment: "Category of the learning outcome (e.g., Knowledge, Skill, Disposition) — used for outcome taxonomy analysis."
    - name: "bloom_taxonomy_level"
      expr: bloom_taxonomy_level
      comment: "Bloom's Taxonomy cognitive level of the outcome — used to assess curriculum rigor and depth of learning."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used to assess the outcome (e.g., Rubric, Exam, Portfolio) — informs assessment quality review."
    - name: "is_accreditation_required"
      expr: is_accreditation_required
      comment: "Whether the PLO is mandated by an accrediting body — critical for compliance gap analysis."
    - name: "is_core_outcome"
      expr: is_core_outcome
      comment: "Whether the PLO is a core institutional outcome — used for strategic alignment reporting."
    - name: "is_general_education"
      expr: is_general_education
      comment: "Whether the PLO is tied to general education requirements — used for gen-ed coverage analysis."
    - name: "assessment_cycle"
      expr: assessment_cycle
      comment: "Assessment cycle cadence (e.g., Annual, Biennial) — used to plan and track assessment completion."
    - name: "catalog_year"
      expr: catalog_year
      comment: "Catalog year the PLO is associated with — used for longitudinal outcome trend analysis."
  measures:
    - name: "total_active_plos"
      expr: COUNT(CASE WHEN outcome_status = 'Active' THEN plo_id END)
      comment: "Total number of active Program Learning Outcomes — baseline metric for outcome portfolio governance."
    - name: "accreditation_required_plo_count"
      expr: COUNT(CASE WHEN is_accreditation_required = TRUE THEN plo_id END)
      comment: "Number of PLOs required by accrediting bodies — compliance exposure metric for accreditation officers."
    - name: "avg_proficiency_threshold_score"
      expr: ROUND(AVG(CAST(proficiency_threshold_score AS DOUBLE)), 2)
      comment: "Average proficiency threshold score across PLOs — benchmarks academic rigor and outcome expectations."
    - name: "avg_target_benchmark_pct"
      expr: ROUND(AVG(CAST(target_benchmark_pct AS DOUBLE)), 2)
      comment: "Average target benchmark percentage across PLOs — used to evaluate whether outcome targets are appropriately ambitious."
    - name: "plos_overdue_for_review"
      expr: COUNT(CASE WHEN next_review_date <= CURRENT_DATE() AND outcome_status = 'Active' THEN plo_id END)
      comment: "Number of active PLOs past their scheduled review date — compliance risk indicator for assessment coordinators."
    - name: "distinct_programs_with_plos"
      expr: COUNT(DISTINCT academic_program_id)
      comment: "Number of distinct academic programs with at least one PLO defined — measures assessment infrastructure coverage."
    - name: "pct_plos_accreditation_required"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_accreditation_required = TRUE THEN plo_id END) / NULLIF(COUNT(CASE WHEN outcome_status = 'Active' THEN plo_id END), 0), 2)
      comment: "Percentage of active PLOs that are accreditation-mandated — used to size compliance workload for accreditation prep."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_program_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program accreditation lifecycle and financial KPIs — used by Provost, compliance officers, and CFO to monitor accreditation status, renewal risk, and accreditation cost exposure."
  source: "`education_ecm`.`curriculum`.`program_accreditation`"
  dimensions:
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status (e.g., Accredited, Probation, Candidacy, Denied) — primary compliance health indicator."
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (e.g., Programmatic, Institutional, Specialized) — used to segment compliance portfolio."
    - name: "accreditation_level"
      expr: accreditation_level
      comment: "Level of accreditation granted — used to assess depth of accreditor recognition."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance standing with accreditation standards — operational risk dimension."
    - name: "annual_report_required"
      expr: annual_report_required
      comment: "Whether an annual accreditation report is required — used to plan compliance reporting workload."
    - name: "interim_report_required"
      expr: interim_report_required
      comment: "Whether an interim report is required — flags additional compliance obligations between full reviews."
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Whether an accreditation appeal has been filed — risk indicator for programs under accreditation challenge."
    - name: "teach_out_plan_required"
      expr: teach_out_plan_required
      comment: "Whether a teach-out plan is required — signals programs at risk of closure or loss of accreditation."
  measures:
    - name: "total_accreditations"
      expr: COUNT(program_accreditation_id)
      comment: "Total number of program accreditation records — baseline compliance portfolio size metric."
    - name: "active_accreditation_count"
      expr: COUNT(CASE WHEN accreditation_status = 'Accredited' THEN program_accreditation_id END)
      comment: "Number of programs with active accreditation — primary compliance health metric for executive reporting."
    - name: "accreditations_expiring_within_12_months"
      expr: COUNT(CASE WHEN accreditation_expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 365) THEN program_accreditation_id END)
      comment: "Accreditations expiring within the next 12 months — forward-looking renewal risk metric for compliance planning."
    - name: "total_annual_accreditation_fees"
      expr: SUM(CAST(accreditation_fees_annual AS DOUBLE))
      comment: "Total annual accreditation fees across all programs — cost exposure metric for CFO budget planning."
    - name: "avg_annual_accreditation_fee"
      expr: ROUND(AVG(CAST(accreditation_fees_annual AS DOUBLE)), 2)
      comment: "Average annual accreditation fee per program — benchmarks accreditation cost per program for budget negotiations."
    - name: "total_estimated_review_fees"
      expr: SUM(CAST(review_fees_estimated AS DOUBLE))
      comment: "Total estimated fees for upcoming accreditation reviews — forward-looking compliance cost projection for CFO."
    - name: "programs_on_probation_or_at_risk"
      expr: COUNT(CASE WHEN accreditation_status IN ('Probation', 'Show Cause', 'Warning') THEN program_accreditation_id END)
      comment: "Number of programs under accreditation probation or warning — critical risk metric requiring immediate leadership attention."
    - name: "programs_with_appeal_filed"
      expr: COUNT(CASE WHEN appeal_filed = TRUE THEN program_accreditation_id END)
      comment: "Number of programs with an active accreditation appeal — legal and reputational risk indicator."
    - name: "pct_accreditations_in_good_standing"
      expr: ROUND(100.0 * COUNT(CASE WHEN accreditation_status = 'Accredited' THEN program_accreditation_id END) / NULLIF(COUNT(program_accreditation_id), 0), 2)
      comment: "Percentage of accreditations in good standing — headline compliance health ratio for board and accreditor reporting."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_concentration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Academic concentration portfolio KPIs — used by Deans and curriculum committees to monitor concentration health, credit hour structure, STEM coverage, and accreditation alignment."
  source: "`education_ecm`.`curriculum`.`concentration`"
  dimensions:
    - name: "concentration_status"
      expr: concentration_status
      comment: "Lifecycle status of the concentration (e.g., Active, Inactive, Pending) — filters operational portfolio."
    - name: "concentration_type"
      expr: concentration_type
      comment: "Type of concentration (e.g., Major, Minor, Certificate) — used to segment curriculum portfolio analysis."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation standing of the concentration — compliance dimension for curriculum governance."
    - name: "stem_designated"
      expr: stem_designated
      comment: "Whether the concentration carries STEM designation — affects OPT eligibility and federal reporting."
    - name: "honors_eligible"
      expr: honors_eligible
      comment: "Whether the concentration is available to honors students — tracks honors program curriculum breadth."
    - name: "thesis_required"
      expr: thesis_required
      comment: "Whether a thesis is required for the concentration — used to assess research intensity and faculty mentoring load."
    - name: "internship_required"
      expr: internship_required
      comment: "Whether an internship is required — tracks experiential learning integration across concentrations."
    - name: "oer_designated"
      expr: oer_designated
      comment: "Whether the concentration uses OER materials — tracks student affordability initiatives."
    - name: "catalog_year"
      expr: catalog_year
      comment: "Catalog year governing the concentration requirements — used for cohort and trend analysis."
    - name: "writing_intensive"
      expr: writing_intensive
      comment: "Whether the concentration has a writing-intensive requirement — used for gen-ed compliance mapping."
  measures:
    - name: "total_active_concentrations"
      expr: COUNT(CASE WHEN concentration_status = 'Active' THEN concentration_id END)
      comment: "Total number of active concentrations — baseline curriculum portfolio breadth metric."
    - name: "avg_required_credit_hours"
      expr: ROUND(AVG(CAST(required_credit_hours AS DOUBLE)), 2)
      comment: "Average required credit hours per concentration — informs degree completion pathway and time-to-degree analysis."
    - name: "avg_core_credit_hours"
      expr: ROUND(AVG(CAST(core_credit_hours AS DOUBLE)), 2)
      comment: "Average core credit hours per concentration — measures curriculum rigor and required instructional depth."
    - name: "avg_elective_credit_hours"
      expr: ROUND(AVG(CAST(elective_credit_hours AS DOUBLE)), 2)
      comment: "Average elective credit hours per concentration — tracks student flexibility and curriculum customization."
    - name: "avg_max_transfer_credit_hours"
      expr: ROUND(AVG(CAST(max_transfer_credit_hours AS DOUBLE)), 2)
      comment: "Average maximum transfer credit hours accepted per concentration — informs transfer student pathway planning."
    - name: "stem_designated_concentration_count"
      expr: COUNT(CASE WHEN stem_designated = TRUE THEN concentration_id END)
      comment: "Number of STEM-designated concentrations — supports STEM program compliance and international student recruitment."
    - name: "pct_concentrations_stem_designated"
      expr: ROUND(100.0 * COUNT(CASE WHEN stem_designated = TRUE THEN concentration_id END) / NULLIF(COUNT(CASE WHEN concentration_status = 'Active' THEN concentration_id END), 0), 2)
      comment: "Percentage of active concentrations with STEM designation — strategic portfolio positioning metric."
    - name: "concentrations_overdue_for_review"
      expr: COUNT(CASE WHEN next_review_date <= CURRENT_DATE() AND concentration_status = 'Active' THEN concentration_id END)
      comment: "Active concentrations past their scheduled curriculum review date — compliance and quality assurance risk indicator."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_articulation_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer pathway and articulation agreement KPIs — used by Enrollment Management and Academic Affairs to monitor partnership health, transfer credit capacity, and agreement renewal risk."
  source: "`education_ecm`.`curriculum`.`articulation_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the articulation agreement (e.g., Active, Expired, Pending) — primary filter for operational agreements."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of articulation agreement (e.g., 2+2, Dual Enrollment, Reverse Transfer) — used to segment partnership analysis."
    - name: "degree_level_from"
      expr: degree_level_from
      comment: "Degree level at the sending institution — used to analyze transfer pathway entry points."
    - name: "degree_level_to"
      expr: degree_level_to
      comment: "Degree level at the receiving institution — used to analyze transfer pathway completion targets."
    - name: "governing_state"
      expr: governing_state
      comment: "State governing the articulation agreement — used for state-mandate compliance and geographic analysis."
    - name: "guaranteed_admission_flag"
      expr: guaranteed_admission_flag
      comment: "Whether the agreement guarantees admission — tracks high-commitment transfer pipeline agreements."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement auto-renews — used to identify agreements requiring active renewal management."
    - name: "scholarship_eligibility_flag"
      expr: scholarship_eligibility_flag
      comment: "Whether transfer students under this agreement are eligible for scholarships — financial aid planning dimension."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN articulation_agreement_id END)
      comment: "Total number of active articulation agreements — baseline transfer partnership portfolio metric."
    - name: "agreements_expiring_within_12_months"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 365) AND agreement_status = 'Active' THEN articulation_agreement_id END)
      comment: "Active agreements expiring within 12 months — renewal risk metric for Enrollment Management planning."
    - name: "avg_total_credit_hours_transferable"
      expr: ROUND(AVG(CAST(total_credit_hours_transferable AS DOUBLE)), 2)
      comment: "Average transferable credit hours per agreement — measures transfer pathway value and time-to-degree impact."
    - name: "total_credit_hours_transferable"
      expr: SUM(CAST(total_credit_hours_transferable AS DOUBLE))
      comment: "Total credit hours transferable across all active agreements — aggregate transfer capacity metric."
    - name: "avg_min_gpa_required"
      expr: ROUND(AVG(CAST(min_gpa_required AS DOUBLE)), 2)
      comment: "Average minimum GPA required for transfer under articulation agreements — benchmarks admission selectivity."
    - name: "guaranteed_admission_agreement_count"
      expr: COUNT(CASE WHEN guaranteed_admission_flag = TRUE THEN articulation_agreement_id END)
      comment: "Number of agreements guaranteeing admission — measures strength of committed transfer pipeline."
    - name: "distinct_partner_institutions"
      expr: COUNT(DISTINCT institution_id)
      comment: "Number of unique partner institutions with active articulation agreements — measures transfer network breadth."
    - name: "avg_residency_requirement_credit_hours"
      expr: ROUND(AVG(CAST(residency_requirement_credit_hours AS DOUBLE)), 2)
      comment: "Average residency credit hour requirement per agreement — informs transfer student degree completion planning."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_transfer_equivalency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer credit equivalency evaluation KPIs — used by Registrar and Academic Affairs to monitor transfer credit volume, approval rates, residency compliance, and evaluation backlog."
  source: "`education_ecm`.`curriculum`.`transfer_equivalency`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the transfer equivalency (e.g., Approved, Pending, Denied) — primary operational filter."
    - name: "equivalency_type"
      expr: equivalency_type
      comment: "Type of equivalency granted (e.g., Direct, General Elective, No Credit) — used to assess transfer credit quality."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current evaluation status — used to track evaluation pipeline and backlog."
    - name: "applies_to_degree_level"
      expr: applies_to_degree_level
      comment: "Degree level the equivalency applies to — used to segment transfer credit analysis by program tier."
    - name: "course_content_match_level"
      expr: course_content_match_level
      comment: "Level of content match between sending and receiving courses — quality indicator for equivalency decisions."
    - name: "counts_toward_residency"
      expr: counts_toward_residency
      comment: "Whether the transferred credit counts toward residency requirements — critical for degree audit compliance."
    - name: "is_reciprocal"
      expr: is_reciprocal
      comment: "Whether the equivalency is reciprocal between institutions — used to identify bilateral transfer partnerships."
    - name: "prerequisite_waived"
      expr: prerequisite_waived
      comment: "Whether a prerequisite was waived based on the transfer credit — tracks academic exception volume."
  measures:
    - name: "total_transfer_equivalencies"
      expr: COUNT(transfer_equivalency_id)
      comment: "Total number of transfer equivalency records — baseline transfer credit evaluation volume metric."
    - name: "approved_equivalency_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN transfer_equivalency_id END)
      comment: "Number of approved transfer equivalencies — measures transfer credit acceptance volume."
    - name: "pct_equivalencies_approved"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN transfer_equivalency_id END) / NULLIF(COUNT(transfer_equivalency_id), 0), 2)
      comment: "Transfer equivalency approval rate — strategic KPI for transfer-friendliness and enrollment competitiveness."
    - name: "total_credit_hours_awarded"
      expr: SUM(CAST(credit_hours_awarded AS DOUBLE))
      comment: "Total credit hours awarded through transfer equivalencies — measures transfer credit volume impact on degree completion."
    - name: "avg_credit_hours_awarded"
      expr: ROUND(AVG(CAST(credit_hours_awarded AS DOUBLE)), 2)
      comment: "Average credit hours awarded per transfer equivalency — benchmarks transfer credit generosity across institutions."
    - name: "total_sending_course_credit_hours"
      expr: SUM(CAST(sending_course_credit_hours AS DOUBLE))
      comment: "Total credit hours from sending institutions — measures raw transfer credit volume entering the institution."
    - name: "avg_max_credit_applicable"
      expr: ROUND(AVG(CAST(max_credit_applicable AS DOUBLE)), 2)
      comment: "Average maximum credit applicable per equivalency — informs transfer credit cap policy analysis."
    - name: "distinct_sending_institutions"
      expr: COUNT(DISTINCT sending_institution_id)
      comment: "Number of unique sending institutions with transfer equivalency records — measures transfer network diversity."
    - name: "pending_evaluation_count"
      expr: COUNT(CASE WHEN evaluation_status = 'Pending' THEN transfer_equivalency_id END)
      comment: "Number of transfer equivalencies pending evaluation — operational backlog metric for Registrar staffing decisions."
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_degree_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Degree requirement structure and compliance KPIs — used by curriculum committees and Registrar to monitor requirement coverage, credit hour thresholds, transfer credit policies, and accreditation alignment."
  source: "`education_ecm`.`curriculum`.`degree_requirement`"
  dimensions:
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of degree requirement (e.g., Core, Elective, Capstone, Gen Ed) — primary slice for curriculum structure analysis."
    - name: "requirement_status"
      expr: requirement_status
      comment: "Current status of the requirement (e.g., Active, Retired, Pending) — filters operational requirements."
    - name: "degree_type"
      expr: degree_type
      comment: "Type of degree the requirement applies to — used to segment analysis by degree program tier."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the requirement — tracks governance workflow completion."
    - name: "is_required"
      expr: is_required
      comment: "Whether the requirement is mandatory — distinguishes required vs. optional curriculum components."
    - name: "allow_transfer_credit"
      expr: allow_transfer_credit
      comment: "Whether transfer credit can satisfy this requirement — informs transfer student degree audit policies."
    - name: "allow_substitution"
      expr: allow_substitution
      comment: "Whether course substitutions are permitted — tracks academic exception policy exposure."
    - name: "diversity_requirement"
      expr: diversity_requirement
      comment: "Whether the requirement fulfills a diversity mandate — used for DEI curriculum compliance reporting."
    - name: "stem_designated"
      expr: stem_designated
      comment: "Whether the requirement is STEM-designated — used for STEM program compliance mapping."
    - name: "writing_intensive"
      expr: writing_intensive
      comment: "Whether the requirement is writing-intensive — used for gen-ed writing requirement coverage analysis."
    - name: "catalog_year"
      expr: catalog_year
      comment: "Catalog year governing the requirement — used for cohort-based degree audit analysis."
  measures:
    - name: "total_active_requirements"
      expr: COUNT(CASE WHEN requirement_status = 'Active' THEN degree_requirement_id END)
      comment: "Total number of active degree requirements — baseline curriculum structure complexity metric."
    - name: "avg_min_credit_hours"
      expr: ROUND(AVG(CAST(min_credit_hours AS DOUBLE)), 2)
      comment: "Average minimum credit hours per degree requirement — benchmarks curriculum depth and degree completion load."
    - name: "avg_max_credit_hours"
      expr: ROUND(AVG(CAST(max_credit_hours AS DOUBLE)), 2)
      comment: "Average maximum credit hours per requirement — used to assess curriculum flexibility and student choice."
    - name: "avg_max_transfer_credit_hours"
      expr: ROUND(AVG(CAST(max_transfer_credit_hours AS DOUBLE)), 2)
      comment: "Average maximum transfer credit hours accepted per requirement — informs transfer student degree completion planning."
    - name: "avg_min_gpa"
      expr: ROUND(AVG(CAST(min_gpa AS DOUBLE)), 2)
      comment: "Average minimum GPA required across degree requirements — benchmarks academic standards across programs."
    - name: "avg_residency_credit_hours"
      expr: ROUND(AVG(CAST(residency_credit_hours AS DOUBLE)), 2)
      comment: "Average residency credit hours required per degree requirement — informs transfer student residency compliance."
    - name: "diversity_requirement_count"
      expr: COUNT(CASE WHEN diversity_requirement = TRUE THEN degree_requirement_id END)
      comment: "Number of requirements with a diversity mandate — DEI curriculum compliance metric for accreditation reporting."
    - name: "transfer_credit_allowed_requirement_count"
      expr: COUNT(CASE WHEN allow_transfer_credit = TRUE THEN degree_requirement_id END)
      comment: "Number of requirements that accept transfer credit — measures transfer pathway flexibility across degree programs."
    - name: "pct_requirements_allowing_transfer_credit"
      expr: ROUND(100.0 * COUNT(CASE WHEN allow_transfer_credit = TRUE THEN degree_requirement_id END) / NULLIF(COUNT(CASE WHEN requirement_status = 'Active' THEN degree_requirement_id END), 0), 2)
      comment: "Percentage of active requirements that accept transfer credit — strategic transfer-friendliness KPI for enrollment leadership."
$$;
