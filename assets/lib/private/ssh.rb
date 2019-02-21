class SSHConfiguration

  include FileUtils

  def initialize(file)
    @file = file
  end

  def add_ssh_key(ssh_key)
    mkdir_p "/root/.ssh"
    ssh_key_file = @file.join("/root/.ssh", "id_rsa")
    @file.open(ssh_key_file, 'w') {|block| block.write(ssh_key)}
  end

  def set_ssh_user(user)
    path = "/serverspec/spec/spec_helper.rb"
    spec_helper_file = @file.read(path)
    spec_helper_file_with_ssh_user_set = spec_helper_file.gsub(/{{ user }}/, user)
    @file.open(path, "w") {|file| file.puts spec_helper_file_with_ssh_user_set}
  end

end