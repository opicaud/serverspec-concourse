require_relative '../../../assets/lib/private/ansible_parser.rb'

describe '::AnsibleParser' do

  context "when I am parsing for ansible host" do
    let(:parser) do
      parser = AnsibleParser.new("spec/resources/ansible_host")
      parser
    end

    it "looking for ansible host" do
      host = parser.findHost
      expect(host).to eq("ec2-35-180-46-86.eu-west-3.compute.amazonaws.com")
    end

    it "looking for ansible user" do
      host = parser.findUser
      expect(host).to eq("admin")
    end
  end
end