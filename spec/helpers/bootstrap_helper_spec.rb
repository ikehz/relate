require 'spec_helper'

describe BootstrapHelper do
  describe "#bootstrap_flash_types" do
    it "maps flash types" do
      expect(helper.bootstrap_flash_types[:success]).to eq('alert-success')
      expect(helper.bootstrap_flash_types[:notice]).to eq('alert-info')
      expect(helper.bootstrap_flash_types[:alert]).to eq('alert-warning')
      expect(helper.bootstrap_flash_types[:error]).to eq('alert-danger')
    end
  end
end
