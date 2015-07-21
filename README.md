# Chappie

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/chappie`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chappie'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chappie

## Usage

The following describes the process of installing a new project and a local development environment with Chappie.

##Dependencies
Before we can use chappie to it's full potential you must have VVV, VV, lftp, and sshpass installed on your local machine.

- [VVV Documentation](https://github.com/Varying-Vagrant-Vagrants/VVV)
- [VV Documentation](https://github.com/bradp/vv)
- [lftp instructions](https://github.com/welaika/wordmove/wiki/Install-lftp-on-OSX-yosemite)
- Use brew to install [sshpass](https://gist.github.com/arunoda/7790979) on your mac.

The rest of Chappie's dependencies will install once you run `gem install chappie`

##Init
Once you have the above installed on your machine, `cd` into your `vvv` directory.

From here you can run the following to create your `Chappiefile`.

`chappie init`

This will create a configuration file with YAML that allows you to plug in your Bitbucket username/password, as well as your ServerPilot API credentials.

Once you configure your **Chappiefile** you're ready to go!

##New Project
As of right now there are two commands for Chappie. The first command is:

`chappie new project <name> <client>`

As you have probably guessed, you replace the name parameter with the project name ( generally the name of the site without the dots or TLD ), and the client code.

From there, Chappie will create a staging site on the team's ServerPilot server, a new bitbucket repository, and a local vagrant environment. (databases included. )

On the local vagrant development environment you will have an initialized git repo containing the latest stable Smores wordpress framework and a Movefile pre-populated with your development and staging environment credentials.

You can begin development of the theme immediately, and Wordmove should inherently work between your dev and staging environments.

##Existing Project
The command you would want to use for an existing project is:

`chappie new local_env <name> <client> -e`

The `-e` or `--exists` flag will take the *name* and *client* parameters and find an existing repository within your team's bitbucket to clone into your newly generated local dev environment.

If you run the command without the `-e` option, the command will generate a new environment with the latest stable Smores framework. ( You will have to activate the theme yourself, I am working on automating this. )

Then all you need to do is `cd` into your new theme directory that's been cloned from Bitbucket and run the proper **wordmove** command to pull in your staging or production site.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/chappie. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
