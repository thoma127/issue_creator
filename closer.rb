require "octokit"
require "uri"

token_file = File.open(".ghec_token")
access_token = token_file.read

# Initialize Octokit client
client = Octokit::Client.new(access_token: access_token)

# List of issue URLs to close
issue_urls = [
  "https://github.com/umn-asr/splunk_config/issues/1",
  "https://github.com/umn-asr/google_app_scripts_deploy/issues/9",
  "https://github.com/umn-asr/google_apps_scripts_core/issues/2",
  "https://github.com/umn-asr/sdp_business_objects/issues/28",
  "https://github.com/umn-asr/uachieve_updated_programs/issues/24",
  "https://github.com/umn-asr/student_athletes/issues/2440"
]

issue_urls.each do |url|
  begin
    # Parse the URL
    uri = URI(url)
    path_parts = uri.path.split("/")

    # Extract owner, repo, and issue number
    owner = path_parts[1]
    repo = path_parts[2]
    issue_number = path_parts[4]

    # Close the issue
    client.close_issue("#{owner}/#{repo}", issue_number.to_i)
    puts "Closed issue: #{url}"
  rescue StandardError => e
    puts "Failed to close issue: #{url}"
    puts "Error: #{e.message}"
  end
end
