require_relative 'private/host.rb'
require_relative 'private/ssh.rb'
require_relative 'private/ansible_parser.rb'
require 'json'


class ServerspecAnsibleConfiguration

  def initialize(jsonFile, hostConfiguration, sshConfiguration, source_concourse)
    @jsonFile = jsonFile
    @hostConfiguration = hostConfiguration
    @sshConfiguration = sshConfiguration
    @source_concourse = source_concourse
    jsonFile = JSON.parse(@jsonFile)
    @source_items = jsonFile["source"]
    @params_items = jsonFile["params"]

  end

  def run()
    runHostConfiguration(@params_items["tests"], host)
    runSshConfiguration(user, @source_items["ssh_key"])
  end


  def host()
    parser = AnsibleParser.new(File.join(@source_concourse, @params_items["inventory"]))
   return parser.findHost
  end

  def user()
    parser = AnsibleParser.new(File.join(@source_concourse, @params_items["inventory"]))
    return parser.findUser
  end

  private

  private

  def runHostConfiguration(tests, host)
    @hostConfiguration.create_host_directory(host)
    @hostConfiguration.copy_spec_to_host_folder(File.join(@source_concourse, tests), host)
  end

  def runSshConfiguration(user, ssh_key)
    @sshConfiguration.set_ssh_user(user)
    @sshConfiguration.add_ssh_key(ssh_key)

  end

end