require "spec_helper"
require "sns_meta_tags"

describe "SnsMetaTags" do
  describe "#canonical" do
    subject { SnsMetaTags.new(url).canonical }

    context 'When http://hatenablog.com/' do
      let(:url) { 'http://hatenablog.com/' }
      it { is_expected.to eq url }
    end

    context 'When duplicate m (http://hatenablog.comm/)' do
      let(:url) { 'http://hatenablog.comm/' }
      it { is_expected.not_to eq url }
    end

  end
end
