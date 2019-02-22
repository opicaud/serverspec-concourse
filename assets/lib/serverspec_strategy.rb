require_relative 'serverspec_configuration.rb'
require_relative 'serverspec_ansible_configuration.rb'


class ServerspecStrategy
  def initialize(json_concourse, hostConfiguration, sshConfiguration,source_concourse)
    @jsonFile = JSON.parse(json_concourse)
    @params = @jsonFile["params"]
    @source = @jsonFile["source"]

    @hostConfiguration = hostConfiguration
    @sshConfiguration = sshConfiguration

    @source_concourse = source_concourse

    @strategy = determineStrategy

  end

  def run()
    runHostConfiguration(@params["tests"], host)
    runSshConfiguration(user, @source["ssh_key"])
  end

  def host()
    @strategy.host
  end

  def user()
    @strategy.user
  end

  private

  def determineStrategy
    if @jsonFile["params"]["inventory"].nil?
      ServerspecConfiguration.new(@source)
    else
      ServerspecAnsibleConfiguration.new(@params, @source_concourse)
    end
  end

  def runHostConfiguration(tests, host)
    @hostConfiguration.create_host_directory(host)
    @hostConfiguration.copy_spec_to_host_folder(File.join(@source_concourse, tests), host)
  end

  def runSshConfiguration(user, ssh_key)
    @sshConfiguration.set_ssh_user(user)
    @sshConfiguration.add_ssh_key(ssh_key)
  end


end