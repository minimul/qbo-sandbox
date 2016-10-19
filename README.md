# Qbo::Sandbox

Copy QuickBooks Online production entities to a sandbox in a single command

## Requirements

Ruby 2.2.2 or greater

## Usage

1. [Clean out](https://developer.intuit.com/hub/blog/2015/12/14/deleting-data-from-your-developer-sandbox-environment) your sandbox.
2. `gem install qbo-sandbox`
3. Put your production and development/sandbox credentials in an .env file. For example `vim ~/qbo-sandbox.env`
    ```
    # ~/.qbo-sandbox.env
    QBO_SANDBOX_PROD_TOKEN=prod_token_xxxxx
    QBO_SANDBOX_PROD_SECRET=prod_secret_xxxx
    QBO_SANDBOX_PROD_REALM_ID=100000000
    QBO_SANDBOX_PROD_CONSUMER_KEY=prod_consumer_key_ddddddd
    QBO_SANDBOX_PROD_CONSUMER_SECRET=prod_consumer_secret_dddddd
    QBO_SANDBOX_TOKEN=token_gggggg
    QBO_SANDBOX_SECRET=secret_ggggg
    QBO_SANDBOX_CONSUMER_KEY=consumer_key_yyyyyy
    QBO_SANDBOX_CONSUMER_SECRET=consumer_secret_sssssss
    QBO_SANDBOX_REALM_ID=2000000000000
    ```
4. `QBO_SANDBOX_ENV_FILE=~/qbo-sandbox.env qbo_sandbox customers`

5. Important: Only tested with QuickBooks Online Name List Resources Customer and Vendor.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/qbo-sandbox.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

