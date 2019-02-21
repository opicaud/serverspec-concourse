require_relative '../../../assets/lib/private/ssh.rb'

describe '::SSHConfiguration' do

  context "when I configure ssh for serverspec, the operating system" do

    let(:file) do
      file = double("File")
      allow(file).to receive(:join).with("/root/.ssh", "id_rsa").and_return("/root/.ssh/id_rsa")
      allow(file).to receive(:open).with("/root/.ssh/id_rsa", 'w').and_yield(block)
      allow(file).to receive(:read).with("/serverspec/spec/spec_helper.rb").and_return("some content with a {{ user }} to replace")
      allow(file).to receive(:open).with("/serverspec/spec/spec_helper.rb", 'w').and_yield(block)
      file
    end


    let(:block) do
      block = double("block")
      allow(block).to receive(:write)
      allow(block).to receive(:puts)
      block
    end

    let(:creator) do
      creator = SSHConfiguration.new(file)
      allow(creator).to receive(:mkdir_p)

      creator
    end

    it "put the ssh-key-provided-by-concourse in /root/.ssh/.id_rsa" do
      creator.add_ssh_key("an-ssh-key-provided-by-concourse")
      expect(block).to have_received(:write).with("an-ssh-key-provided-by-concourse")
    end

    it "change the user in the helper with the ssh user provided by concourse" do
      creator.set_ssh_user("ssh-user-provided-by-concourse")
      expect(block).to have_received(:puts).with("some content with a ssh-user-provided-by-concourse to replace")
    end

  end
end