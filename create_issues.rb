require "octokit"

token_file = File.open(".ghec_token")
access_token = token_file.read

# Initialize Octokit client
client = Octokit::Client.new(access_token: access_token)

# Repository where the issue will be created
repo = "umn-asr/sdp_api"

# List of files to create issues for
first_files = [
  "features/extracting_facet_from_rochester_spec.rb:1",
  "features/declared_program_request_test.rb:1",
  "models/etl/audit/facet/global_statistic/in_progress_credits_spec.rb:1",
  "models/etl/audit/facet/global_statistic/free_elective_credits_required_spec.rb:2",
  "models/etl/audit/facet/global_statistic/required_credits_spec.rb:5",
  "models/etl/audit/facet/global_statistic/percent_complete_spec.rb:1",
  "models/etl/audit/facet/global_statistic/audit_type_spec.rb:2",
  "models/etl/audit/facet/global_statistic/degree_complete_spec.rb:1",
  "models/etl/audit/facet/global_statistic/current_term_umn_credits_spec.rb:1",
  "models/etl/audit/facet/global_statistic/audit_title_spec.rb:1",
  "models/etl/audit/facet/global_statistic/credit_count_spec.rb:7"
]

files = [
  "models/etl/audit/facet/global_statistic/non_umn_credits_spec.rb:6",
  "models/etl/audit/facet/global_statistic/complete_status_message_spec.rb:3",
  "models/etl/audit/facet/metadata/defect/course_absent_from_standard_bucket_spec.rb:1",
  "models/etl/audit/facet/metadata/defect/countable_electives_spec.rb:1",
  "models/etl/audit/facet/term_statistic/major_credits_spec.rb:1",
  "models/etl/audit/facet/metadata/defect/required_credits_outside_expected_range_spec.rb:1",
  "models/etl/audit/facet/metadata/error/dprog_is_nil_spec.rb:1",
  "models/etl/audit/facet/metadata/error/required_credits_out_of_range_spec.rb:1",
  "models/etl/audit/facet/metadata/error/instcd_is_unknown_spec.rb:1",
  "models/etl/audit/facet/metadata/error/marked_with_error_complete_status_spec.rb:1",
  "models/db_audit_view/course_history_subrequirements_csom_spec.rb:1",
  "models/etl/audit_spec.rb:3",
  "support/iron_fixture_setup_helpers/load_two_audits_cla_and_cse_honors_mirrored.rb:1"
]

# Create an issue for each file
files.each do |file|
  issue_title = "Remove dependency on "Iron Fixture Extractor" in #{file.split(":").first}"
  issue_body = <<-BODY
Remove the dependency on Iron Fixture Extractor in the file `#{file.split(":").first} and replace it with `factory_bot`.
  BODY

  client.create_issue(repo, issue_title, issue_body)
  puts "Created issue for #{file}"
end

puts "All issues have been created."
