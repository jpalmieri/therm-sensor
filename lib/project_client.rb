require_relative "http_client.rb"

# interface for projects on Therm API
module ThermSensor
  class ProjectClient

    def initialize(project_id)
      @project_id = project_id
    end

    def post_temp(value)
      target = "/projects/#{@project_id}/temps"
      options = { value: value }
      client.post(target, options)
    end

    def get_temps
      target = "/projects/#{@project_id}/temps"
      client.get(target)
    end

    private

    def client
      @client ||= ThermSensor::HTTPClient.new
    end
  end
end
