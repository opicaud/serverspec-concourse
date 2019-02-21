class AnsibleParser

  def initialize(ansible_host)
    @content = File.read(ansible_host)
  end

  def findHost
    return @content.scan(/ansible_host=[a-zA-Z0-9\-.]*/)[0].split('=')[1]
  end

  def findUser
    return @content.scan(/ansible_user=[a-zA-Z0-9\-.]*/)[0].split('=')[1]
  end

end