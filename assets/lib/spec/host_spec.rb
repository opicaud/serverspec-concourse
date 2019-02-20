require_relative '../host.rb'

describe '::CreateHostConfiguration' do

context "when I configure serverspec, the operating system" do
   let(:creator) do
    creator=CreateHostConfiguration.new
    allow(creator).to receive(:mkdir_p)
    allow(creator).to receive(:cp)
    creator
   end

   it "create folder /serverspec/host-under-test" do
        creator.create_host_directory("/serverspec","/host-under-test")
        expect(creator).to have_received(:mkdir_p).with("/serverspec/host-under-test")
   end

   it "copy test files provided by concourse to /serverspec/host-under-test" do
        creator.copy_spec_to_host_folder("/folder-from-concourse","/serverspec","/host-under-test")
        expect(creator).to have_received(:cp).with("/folder-from-concourse","/serverspec/host-under-test")
   end


end
end