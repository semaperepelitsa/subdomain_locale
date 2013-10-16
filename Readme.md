# Subdomain Locale (for Rails)

Moves current locale into subdomain. Installation is quick and simple:

    # Gemfile
    gem 'subdomain_locale', '~> 0.1.0'

    # config/application.rb
    config.i18n.available_locales = [:ru, :az, :en, "en-US"] # Put your own available locales
    config.i18n.default_locale = :az                         # and make one default

Now, start your web server at localhost:3000 and navigate:

    http://lvh.me:3000/ - the default locale (:az)
    http://ru.lvh.me:3000/ - I18n.locale is set to :ru
    http://en-us.lvh.me:3000/ - I18n.locale is set to :en-US
    http://www.lvh.me:3000/ - again, default

You can also put links to all locales in your view:

    <% I18n.available_locales.each do |locale| %>
      <%= link_to locale, params.merge(locale: locale) %>
    <% end %>

## Configuring own subdomain-to-locale mapping

```ruby
# config/application.rb

config.subdomain_locales["us"] = "en-US"
# or even
# config.subdomain_locales = {"us" => "en-US", "ca" => "en-CA"}
```

Having that configured `http://us.lvh.me:3000` will be rendered with :en-US locale.


## Changelog

master

* Support IETF language tag subdomains, e.g. pt-br.
* Allow to create custom mappings, e.g. "us" instead of "en-us".

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

