# frozen_string_literal: true

module JsonServiceHandler
  def run(service, params, serializer: nil)
    result = service.call(params)
    return render_data(result[:data], result[:status], serializer) if result[:data].present?

    render_error(result[:errors], result[:status])
  end

  private

  def render_error(errors, status)
    render json: { errors: errors }, status: status
  end

  def render_data(data, status, serializer)
    render json: data, status: status, serializer: serializer
  end
end
