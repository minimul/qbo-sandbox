require "qbo/sandbox/version"
require "dotenv"
require "qbo_api"

module Qbo
  class Sandbox
    attr_reader :prod, :sandbox
    def initialize(**args)
      load_env!
      keyword_args.merge(args).each do |key, val|
        unless val
          args[key] = get_env(key)
        end
      end
      init_sandbox(args)
      init_prod(args)
    end

    def get_env(key)
      env_var = 'QBO_SANDBOX_' + key.to_s.upcase
      ENV.fetch(env_var) { |k| raise "Missing value for either ENV['#{k}'] or keyword argument #{key}" }
    end

    def copy(entity, max: 1000, select: nil, inactive: false)
      payload = { "BatchItemRequest" => [] }
      QboApi.production = true
      #@prod.query(select)
      @prod.all(entity, max: max, select: select, inactive: inactive) do |e|
        payload["BatchItemRequest"] << build_single_batch(e, entity)
      end
      QboApi.production = false
      @sandbox.batch payload
    end

    private

    def keyword_args
      {
        token: nil,
        secret: nil,
        realm_id: nil,
        consumer_key: nil,
        consumer_secret: nil,
        prod_token: nil,
        prod_secret: nil,
        prod_realm_id: nil,
        prod_consumer_key: nil,
        prod_consumer_secret: nil
      }
    end

    def init_sandbox(args)
      @sandbox = QboApi.new(token: args[:token], 
                            token_secret: args[:secret], 
                            realm_id: args[:realm_id],
                            consumer_key: args[:consumer_key], 
                            consumer_secret: args[:consumer_secret])
    end
    
    def init_prod(args)
      @prod = QboApi.new(token: args[:prod_token], 
                         token_secret: args[:prod_secret], 
                         realm_id: args[:prod_realm_id],
                         consumer_key: args[:prod_consumer_key], 
                         consumer_secret: args[:prod_consumer_secret])
      
    end

    def build_single_batch(e, entity)
      {
        "bId" => "bid#{e.delete('Id')}",
        "operation" => "create",
        @prod.singular(entity) => e
      }
    end

    def load_env!
      if ENV.has_key?('QBO_SANDBOX_ENV_FILE')
        Dotenv.load(ENV['QBO_SANDBOX_ENV_FILE'])
      else
        Dotenv.load
      end
    end
  end
end
