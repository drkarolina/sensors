# frozen_string_literal: true

module JsonHelper
  def validate_json_schema(schema_name, response_body)
    schema_path = Rails.root.join("spec/support/schemas/#{schema_name}.json")
    schema = JSON.parse(File.read(schema_path))
    JSON::Validator.validate!(schema, response_body, strict: true)
  end
end
