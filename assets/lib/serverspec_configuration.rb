require_relative 'private/host.rb'
require_relative 'private/ssh.rb'
require 'json'


class ServerspecConfiguration

  def initialize(source_items)
    @source_items = source_items
  end

  def host()
    @source_items["host"]
  end

  def user()
    @source_items["user"]
  end



end