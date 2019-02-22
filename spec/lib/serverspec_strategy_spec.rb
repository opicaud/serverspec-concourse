require_relative '../../assets/lib/../../assets/lib/serverspec_strategy.rb'

require 'json'

describe '::ServerSpecStrategy' do

  context "when Concourse run the out script, " do

    let(:hostConfiguration) do
      hostConfiguration = double("HostConfiguration")
      allow(hostConfiguration).to receive(:create_host_directory)
      allow(hostConfiguration).to receive(:copy_spec_to_host_folder)
      hostConfiguration
    end

    let(:sshConfiguration) do
      sshConfiguration = double("SSHConfiguration")
      allow(sshConfiguration).to receive(:set_ssh_user)
      allow(sshConfiguration).to receive(:add_ssh_key)
      sshConfiguration
    end


    let(:defaultConfiguration) do
      defaultConfiguration = File.read('spec/resources/source.json')
      defaultConfiguration
    end

    let(:ansibleConfiguration) do
      ansibleConfiguration = File.read('spec/resources/source_with_ansible.json')
      ansibleConfiguration
    end

    context "when inventory is not present in the concourse json " do

      let(:strategy) do
        strategy = ServerspecStrategy.new(defaultConfiguration, hostConfiguration, sshConfiguration, ".")
        strategy
      end

      it "use the strategy ServerSpecConfiguration by default" do
        expect(strategy.instance_variable_get(:@strategy)).to be_an_instance_of(ServerspecConfiguration)
      end

      it "configure the host from the json" do
        strategy.run
        expect(hostConfiguration).to have_received(:create_host_directory).with(JSON.parse(defaultConfiguration)["source"]["host"])

      end

      it "copy the tests in the host folder" do
        strategy.run
        expect(hostConfiguration).to have_received(:copy_spec_to_host_folder).with("./plop", JSON.parse(defaultConfiguration)["source"]["host"])
      end

      it "configure the SSH user from the Json" do
        strategy.run
        expect(sshConfiguration).to have_received(:set_ssh_user).with(JSON.parse(defaultConfiguration)["source"]["user"])

      end

      it "add the ssh key from the JSON" do
        strategy.run
        expect(sshConfiguration).to have_received(:add_ssh_key).with(JSON.parse(defaultConfiguration)["source"]["ssh_key"])

      end

    end

    context "when inventory is present in the concourse json " do

      let(:strategy) do
        strategy = ServerspecStrategy.new(ansibleConfiguration, hostConfiguration, sshConfiguration, ".")
        strategy
      end


      it "use the ansible strategy if ansible is present in the jsonFile" do
        strategy.run
        expect(strategy.instance_variable_get(:@strategy)).to be_an_instance_of(ServerspecAnsibleConfiguration)
      end

      it "configure the host with the ansible_host" do
        strategy.run
        expect(hostConfiguration).to have_received(:create_host_directory).with("ec2-35-180-46-86.eu-west-3.compute.amazonaws.com")
      end

      it "copy the tests in the host folder" do
        strategy.run
        expect(hostConfiguration).to have_received(:copy_spec_to_host_folder).with("./plop", "ec2-35-180-46-86.eu-west-3.compute.amazonaws.com")
      end

      it "configure SSH with the ansible_user" do
        strategy.run
        expect(sshConfiguration).to have_received(:set_ssh_user).with("admin")

      end

      it "add the ssh key from the JSON" do
        strategy.run
        expect(sshConfiguration).to have_received(:add_ssh_key).with(JSON.parse(defaultConfiguration)["source"]["ssh_key"])

      end
    end

  end
end