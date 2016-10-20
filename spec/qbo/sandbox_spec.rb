require "spec_helper"

describe Qbo::Sandbox do

  before do
    ENV['QBO_SANDBOX_ENV_FILE'] = "#{__dir__}/../fixtures/test.env"
  end

  after do
    ENV.delete('QBO_SANDBOX_ENV_FILE')
  end

  it "initializes arguments and takes prod_realm_id from .env file as its value is nil" do
    qbo_sandbox = Qbo::Sandbox.new(token: 'token', 
                     secret: 'secret', 
                     realm_id: 'realm_id', 
                     consumer_key: 'consumer_key', 
                     consumer_secret: 'consumer_secret', 
                     prod_token: 'prod_token', 
                     prod_secret: 'prod_secret', 
                     prod_realm_id: nil, 
                     prod_consumer_key: 'prod_consumer_key', 
                     prod_consumer_secret: 'prod_consumer_secret')
    expect(qbo_sandbox.sandbox.realm_id).to eq 'realm_id'
    expect(qbo_sandbox.prod.realm_id).to match /^1.+$/
  end

  it "take values from a specified dotenv file" do
    qbo_sandbox = Qbo::Sandbox.new
    expect(qbo_sandbox.sandbox.realm_id).to match /^2.+$/
  end

  it "copies QBO production customers to the sandbox" do
    WebMock.stub_request(:get, /.*query=SELECT.*Customer.*/).to_return(body: fixture(:customers))
    WebMock.stub_request(:post, /^.*batch$/).to_return(body: fixture(:customer_batch_response))
    qbo_sandbox = Qbo::Sandbox.new
    #QboApi.log = true
    resp = qbo_sandbox.copy :customers
    expect(resp.first["BatchItemResponse"].size).to eq 3
  end

  it "copies QBO production vendors to the sandbox" do
    WebMock.stub_request(:get, /.*query=SELECT.*Vendor.*/).to_return(body: fixture(:vendors))
    WebMock.stub_request(:post, /^.*batch$/).to_return(body: fixture(:vendor_batch_response))
    qbo_sandbox = Qbo::Sandbox.new
    #QboApi.log = true
    resp = qbo_sandbox.copy :vendors
    expect(resp.first["BatchItemResponse"].size).to eq 3
  end

  it "copies QBO production items to the sandbox in batches of 2" do
    WebMock.stub_request(:get, /.*query=SELECT.*Item.*/).to_return(body: fixture(:items))
    WebMock.stub_request(:post, /^.*batch$/).to_return(body: fixture(:item_batch_response_1))
    qbo_sandbox = Qbo::Sandbox.new
    resp = qbo_sandbox.copy :items, batch_size: 2
    expect(resp.size).to eq 2
  end
end
