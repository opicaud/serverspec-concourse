require_relative 'private/host.rb'
require_relative 'private/ssh.rb'
require_relative 'private/ansible_parser.rb'
require 'json'


class ServerspecAnsibleConfiguration

  def initialize(params_items, source_concourse)
    @parser = AnsibleParser.new(File.join(source_concourse, params_items["inventory"]))
  end

  def host()
    @parser.findHost
  end

  def user()
    @parser.findUser
  end

end