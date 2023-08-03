# MasterMind

Master Mind CLI is a command-line interface (CLI) implementation of the popular game Master Mind.

Test your code-breaking skills by attempting to guess the secret pattern within the specified number of attempts. Have fun playing and mastering the code-breaking challenge with Master Mind CLI!

Ruby code is located the file `lib/` directory.

To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Clone project:

```bash
git clone https://github.com/Nick-Damico/ruby-master-mind.git
```

Setup Project with dependencies

```bash
./bin/setup
```

Execute App

```bash
./exe/mastermind
```

## Docker

Install Docker Desktop https://www.docker.com/get-started/

Build Image

```bash
docker build --tag local/master_mind-1.0 .
```

Start shell in Container

```bash
docker run --rm -it local/master_mind-1.0 sh
```

## Development

After checking out the repo, run this command
to install dependencies.

```bash
./bin/setup
```

Then, run this command to run the test suite.

```bash
rake spec
```

You can also this command for an interactive prompt that will allow you to experiment.

```bash
bin/console
```

To install this gem onto your local machine, run

```bash
bundle exec rake install
```

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/master_mind.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
