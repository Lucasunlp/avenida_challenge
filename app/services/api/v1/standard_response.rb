class Api::V1::StandardResponse
  VALIDS_STATUS = %w[ok warning error].freeze
  def call(data:, status:)
    data = 'Not found elements' if data.blank?
    status_valid?(status)
    {
      status: status,
      data: data
    }
  end

  private

  def status_valid?(status)
    if VALIDS_STATUS.exclude?(status)
      raise ArgumentError, "Unknown status #{status}."
    end
  end
end
