# Changelog

## 1.6.0

- Support color 2.x, whose color objects are immutable, while retaining support
  for color 1.x and the existing SVG fixtures.
- Declare the base64, logger, and rake runtime dependencies so the gem and its Rake
  integration work under Bundler on modern Ruby versions.
- Test Ruby 3.3, 3.4, 4.0, and Ruby head against color 1.x and 2.x in CI.
- Verify the built gem in CI with only its runtime dependencies installed.
- Publish version tags through GitHub Actions using RubyGems trusted publishing,
  after the test and package checks pass.
- Remove unused ActiveSupport, documentation, and debugger dependencies from
  the development bundle.
- Update coverage configuration for SimpleCov 1.3. Development tools require
  Ruby 3.3 or newer.
- Package the library, README, license, and changelog without requiring Git.

The minimum Ruby version remains 2.6.

## 1.5.0 — 2023-04-05

- Fix Ruby 3 compatibility.
- Require Ruby 2.6 or newer.
