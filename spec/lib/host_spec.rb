require_relative '../../assets/lib/host.rb'

describe '::HostConfiguration' do

context "when I configure serverspec, the operating system" do
   let(:creator) do
    creator=HostConfiguration.new
    allow(creator).to receive(:mkdir_p)
    allow(creator).to receive(:cp)
    creator
   end

   it "create folder /serverspec/spec/host-under-test" do
        creator.create_host_directory("host-under-test")
        expect(creator).to have_received(:mkdir_p).with("/serverspec/spec/host-under-test")
   end

   it "copy test files provided by concourse to /serverspec/host-under-test" do
        creator.copy_spec_to_host_folder("folder-from-concourse","host-under-test")
        expect(creator).to have_received(:cp).with("folder-from-concourse","/serverspec/spec/host-under-test")
   end


end
end