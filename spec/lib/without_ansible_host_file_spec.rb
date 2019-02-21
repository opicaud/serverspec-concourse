require_relative '../../assets/lib/without_ansible_host_file.rb'
require 'json'

describe '::WithoutAnsibleHostFile' do

context "when Concourse run the out script, " do
   let(:hostConfiguration) do
    hostConfiguration=CreateHostConfiguration.new
    allow(hostConfiguration).to receive(:create_host_directory)
    allow(hostConfiguration).to receive(:copy_spec_to_host_folder)
    hostConfiguration
   end

    let(:sshConfiguration) do
       sshConfiguration=double("CreateSSHConfiguration")
       allow(sshConfiguration).to receive(:set_ssh_user)
       allow(sshConfiguration).to receive(:add_ssh_key)
       sshConfiguration
      end

   let(:jsonFile) do
    jsonFile = File.read('spec/lib/source.json')
    jsonFile
   end

   let(:withoutAnsibleHostFile) do
    withoutAnsibleHostFile=WithoutAnsibleHostFile.new(jsonFile,hostConfiguration,sshConfiguration,"source_concourse")
    withoutAnsibleHostFile
   end


   it "configure the host folder in order to run the specs" do
    withoutAnsibleHostFile.run
    expect(hostConfiguration).to have_received(:create_host_directory).with(JSON.parse(jsonFile)["source"]["host"])
   end

   it "copy the spec to the host folder" do
       withoutAnsibleHostFile.run
       path="source_concourse/" + JSON.parse(jsonFile)["params"]["tests"]
       expect(hostConfiguration).to have_received(:copy_spec_to_host_folder).with(path,JSON.parse(jsonFile)["source"]["host"])
   end

    it "set the ssh user from the json" do
          withoutAnsibleHostFile.run
          expect(sshConfiguration).to have_received(:set_ssh_user).with(JSON.parse(jsonFile)["source"]["user"])
    end

     it "set the ssh key from the json" do
              withoutAnsibleHostFile.run
              expect(sshConfiguration).to have_received(:add_ssh_key).with(JSON.parse(jsonFile)["source"]["ssh_key"])
        end


end
end