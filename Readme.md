# Subdomain Locale (for Rails)

A multi-language website requires some way to detect a user's locale.
Subdomain is one option.

## Setup

Add the gem to your Gemfile:

```ruby
gem "subdomain_locale"
```

Set a default subdomain:

```ruby
# config/application.rb

# I18n library now recommends you to enforce available locales.
config.i18n.enforce_available_locales = true
config.i18n.available_locales = :en, :ru

# See "Configuration" for difference between these:
config.default_locale = :ru
config.i18n.default_locale = :en
```

Subdomains will now determine the current locale:

* Selected locale (:en) http://en.example.com/
* Default locale (:ru) http://example.com/

Add links to the new subdomains using :locale URL parameter:

```erb
<% [:ru, :en].each do |locale| %>
  <%= link_to locale, params.merge(locale: locale) %>
<% end %>
```

## Configuration

You can hook a special subdomain name with a locale:

```ruby
config.subdomain_locale["us"] = :"en-US" # us.lvh.me
config.subdomain_locale["ca"] = :"en-CA" # ca.lvh.me
config.subdomain_locale["ua"] = :uk      # ua.lvh.me
```

Default locale will link to the default subdomain (main domain by default: lvh.me).
If you prefer "www" use this config option:

```ruby
config.default_subdomain = "www"
```

English developers prefer to see English in console and other places.
This is why we have a separate default locale for the website:

```ruby
config.default_locale = :ru
config.i18n.default_locale = :en
```

For example, with this config example.com will be in Russian,
while validation errors in console are still in English.


You can also override our controller method to completely ignore subdomain locale.
For example, if you want admin panel to always be in English:

```ruby
class AdminController
  # This is already an around_action
  def set_locale(&block)
    I18n.with_locale(:en, &block)
  end
end
```

## Testing

This gem is tested against Rails 3.2, 4.0 and 4.1.

```
gem install isolate
rake test:all
```

## Changelog

1.2.0

* Support Rails 4.2 and I18n 0.7; drop Rails 3.2.
* Note: Rails 4.2 is more strict about `_path/_url` helpers. Make sure to use `_url` helper whenever you specify locale parameter:

  ```ruby
  root_path(locale: :ru) # bad, will raise deprecation warning
  root_url(locale: :ru)  # good
  ```

1.1.0

* Custom subdomain provided in your default_url_options now has precedence over the default subdomain-locale.

1.0.0

* Links outside controllers now also point to the current locale. For example, in mailers.
* Now compatible with the new I18n.enforce\_available\_locales.
* No subdomain is now deafult instead of "www". Can be reverted by setting config.default\_domain.
* Separate website's default locale (config.default\_locale) from the global default locale (config.i18n.default\_locale).
* Test gem in the whole Rails stack (3.2, 4.0).
* Add config.subdomain_locale for indirect mapping ("us" => :"en-US").

0.1.1

* Adding changelog to the readme.
* Don't require files until they needed. That means less boot time impact.

0.1.0. Minor internal changes & fixes, documentation.

* Fixing url_for's argument modified.
* Adding readme and documentation.
* Using require instead of autoload.
* Refactoring tests.
* Clearly specifying I18n dependency.

0.0.1—0.0.3. Initial releases.

