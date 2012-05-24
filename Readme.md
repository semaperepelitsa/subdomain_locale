# Subdomain Locale (for Rails)

Moves current locale into subdomain. Installation is quick and simple:

    # Gemfile
    gem 'subdomain_locale', '~> 0.1.0'

    # config/application.rb
    config.i18n.available_locales = [:ru, :az, :en] # Put your own available locales
    config.i18n.default_locale = :az                # and make one default

Now, start your web server at localhost:3000 and navigate:

    http://lvh.me:3000/ - the default locale (:az)
    http://ru.lvh.me:3000/ - I18n.locale is set to :ru
    http://www.lvh.me:3000/ - again, default

You can also put links to all locales in your view:

    <% I18n.available_locales.each do |locale| %>
      <%= link_to locale, params.merge(locale: locale) %>
    <% end %>
