require "spec_helper"
require "my_http"

require 'webmock/rspec'
include WebMock::API
WebMock.allow_net_connect!

describe "MyHttp" do
  describe "#my_method" do
    subject { MyHttp.new.my_method(url) }
    let(:url) { 'http://www.excale.com/' }

    context 'When status 200' do
      before { stub_request(:any, url).to_return(status: 200) }
      it { is_expected.to eq "OK" }
    end

    context 'When status 404' do
      before { stub_request(:any, url).to_return(status: 404) }
      it { is_expected.to eq "Status code: 404" }
    end

  end
end
