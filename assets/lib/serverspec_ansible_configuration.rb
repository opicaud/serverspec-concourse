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
    runSshConfiguration(user,@source_items["ssh_key"])
  end


  def host()
    parser = AnsibleParser.new(@params_items["inventory"])
   return parser.findHost
  end

  def user()
    parser = AnsibleParser.new(@params_items["inventory"])
    return parser.findUser
  end

  private


end