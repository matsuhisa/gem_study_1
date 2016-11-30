require "spec_helper"
require "sns_meta_tags"

require 'webmock/rspec'
include WebMock::API
WebMock.allow_net_connect!

describe "SnsMetaTags" do
  describe "#page_read" do
    subject { SnsMetaTags.new(url).send(:page_read) }
    let(:url) { 'http://www.excale.com/' }

    context 'When status 404' do
      before { stub_request(:any, url).to_return(status: 404) }
      it { is_expected.to be_nil }
    end
  end

  describe "#canonical" do
    subject { SnsMetaTags.new(url).canonical }
    let(:url) { 'http://www.excale.com/' }

    context 'When status 200 and have canonical' do
      before {
        stub_request(:any, url).to_return(
          status: 200,
          body: "<link href='#{url}' rel='canonical'>"
        )
      }
      it { is_expected.to eq url }
    end

    context 'When status 200 and no canonical' do
      before { stub_request(:any, url).to_return(status: 200) }
      it { is_expected.to eq nil }
    end
  end

  describe "#og_images" do
    subject { SnsMetaTags.new(url).og_images }
    let(:url) { 'http://www.excale.com/' }

    context 'When status 200 and have og:image' do
      html_string = <<"EOS"
      <meta property="og:image" content="http://www.excale.com/1.png">
      <meta property="og:image" content='http://www.excale.com/2.png'>
EOS

      before {
        stub_request(:any, url).to_return(
          status: 200,
          body: html_string
        )
      }
      it { is_expected.not_to contain_exactly('http://www.excale.com/1.png') }
      it { is_expected.not_to contain_exactly('http://www.excale.com/2.png') }
      it { is_expected.to contain_exactly('http://www.excale.com/1.png', 'http://www.excale.com/2.png') }
    end

    context 'When status 200 and no have og:image' do
      subject { SnsMetaTags.new(url).og_images }
      let(:url) { 'http://www.excale.com/' }

      before {
        stub_request(:any, url).to_return(
            status: 200,
            body: ""
        )
      }
      it { is_expected.to contain_exactly() }
    end
  end
end
