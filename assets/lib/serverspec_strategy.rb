require_relative 'serverspec_configuration.rb'
require_relative 'serverspec_ansible_configuration.rb'


class ServerspecStrategy
  def initialize(json_concourse)
    if JSON.parse(json_concourse)["params"]["inventory"].nil?
      @strategy=ServerspecConfiguration.new(json_concourse,HostConfiguration.new, SSHConfiguration.new(File), ARGV[0])
    else
      @strategy=ServerspecAnsibleConfiguration.new(json_concourse,HostConfiguration.new, SSHConfiguration.new(File), ARGV[0])

    end

  end

  def run()
    return @strategy.run
  end

  def host()
    return @strategy.host
  end

  def user()
    return @strategy.user
  end

end