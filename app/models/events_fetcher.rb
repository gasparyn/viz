class EventsFetcher
  VALUES = %w[
    indoor
    outdoor
    camp
    purchasable
    for_kids
    updated
  ].freeze

  CareEvent = Struct.new(:indoor, :outdoor, :camp, :purchasable, :for_kids, :updated)

  def initialize(page = 1, per_page = 30)
    response = ApiClient.new(page, per_page).get
    @body = JSON.parse(response.body)
  end

  def activities
    data = body['activities'].map(&method(:select_and_transform))

    { name: 'activities', data: group_by_time(data) }
  end

  def series
    data = body['series'].map(&method(:select_and_transform))

    { name: 'series', data: group_by_time(data) }
  end

  private

  attr_reader :body

  def select_and_transform(hash)
    CareEvent.new.tap do |struct|
      hash.select { |k, _v| VALUES.include?(k) }.each do |k,v|
        struct.send("#{k}=", v)
      end
    end
  end

  def group_by_time(data)
    data.group_by { |a| Time.at(a.updated).beginning_of_day }.transform_values(&:count)
  end
end
