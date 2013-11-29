shared_examples "an owned model" do
  it "is invalid without an owner" do
    expect(described_class.make(owner: nil)).not_to be_valid
  end
end
