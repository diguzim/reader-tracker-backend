# frozen_string_literal: true

module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def report_forbidden_errors
    expect(response).to have_http_status(403)
    expect(response.body).to match(/You don't have the permission to handle this resource/)
  end
end
