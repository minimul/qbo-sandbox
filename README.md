# Qbo::Sandbox

Copy QuickBooks Online production entities to a sandbox in a single command

## Requirements

Ruby 2.2.2 or greater

## Usage

1. [Clean out](https://developer.intuit.com/hub/blog/2015/12/14/deleting-data-from-your-developer-sandbox-environment) your sandbox.

2. `gem install qbo-sandbox`

3. Enter in your production and sandbox credentials into a .env file of your choosing. 

   For example, here is a .env file at `~/qbo-sandbox.env`

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

    All variables need to filled in. The `PROD` variables are your QuickBooks Online production credentials

4. **`QBO_SANDBOX_ENV_FILE=~/qbo-sandbox.env qbo-sandbox customers`**

5. That's it!

## FAQ

- What if I set they wrong credentials and copy entities from the sandbox to the production QuickBooks Online account?

    There is a bit of protection against [this] (https://github.com/minimul/qbo-sandbox/blob/master/lib/qbo/sandbox.rb#L31) but use of this library is at your own risk so be careful to set your credentials correctly.

- Will this library generate a ton of requests and hit API throttle requirements?

    No, to create the sandbox entities this library uses [batch requests](https://developer.intuit.com/docs/api/accounting/batch).

- My QBO Sub-customers, certain Items, etc. are not copying over to the sandbox?

    Name list and transaction entities that have references are going to fail because the reference id is not going to be available on the sandbox. This library is not going to support references anytime soon but pull requests are very welcome. This library is only tested with QuickBooks Online Customer, Vendor, and Items. Sub-customers and inventory items that have required references to accounts will not be copied to your sandbox.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To run the command locally:

```
bundle exec ./bin/qbo-sandbox vendors
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/minimul/qbo-sandbox.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

