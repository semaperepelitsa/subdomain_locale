class BetaMailer < HelloMailer
  def default_url_options
    super.merge(subdomain: "beta")
  end
end
