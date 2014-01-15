require 'spec_helper'

describe ConversationsHelper do
  describe "#truncate_participants" do
    context "when given no participants" do
      it "returns empty" do
        expect(helper.truncate_participants []).to be_empty
      end
    end

    context "when given one participant" do
      it "returns that participant's name" do
        c = Participant.make
        expect(helper.truncate_participants [c]).to eq(c.contact_name)
      end
    end

    context "when given a conversation with two participants" do
      it "returns 'name, name'" do
        c = Participant.make
        d = Participant.make
        expect(helper.truncate_participants [c, d]).to eq("#{c.contact_name}, #{d.contact_name}")
      end
    end

    context "when given a conversation with three participants" do
      it "returns 'name, name, ...'" do
        c = Participant.make
        d = Participant.make
        e = Participant.make
        expect(helper.truncate_participants [c, d, e]).to eq("#{c.contact_name}, #{d.contact_name}, ...")
      end
    end
  end
end
