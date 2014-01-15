require 'spec_helper'

describe ConversationsHelper do
  describe "#truncate_participants" do
    context "when given no participants" do
      it "returns empty" do
        p = []
        expect(helper.truncate_participants p).to be_empty
      end
    end

    context "when given one participant" do
      it "returns that participant's name" do
        p = [Participant.make]
        expect(helper.truncate_participants p).to eq(p[0].contact_name)
      end
    end

    context "when given a conversation with two participants" do
      it "returns 'name, name'" do
        p = Array.new(2) { Participant.make }
        expect(helper.truncate_participants p).to eq("#{p[0].contact_name}, #{p[1].contact_name}")
      end
    end

    context "when given a conversation with three participants" do
      it "returns 'name, name, ...'" do
        p = Array.new(3) { Participant.make }
        expect(helper.truncate_participants p).to eq("#{p[0].contact_name}, #{p[1].contact_name}, ...")
      end
    end
  end
end
