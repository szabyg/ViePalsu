exports.registerRoutes = (server, prefix, authentication) ->
  server.get "#{prefix}", (req, res, next) ->
    if req.isAuthenticated()
      return res.redirect '/m'
    res.redirect "#{prefix}linkedin"

  server.get "#{prefix}linkedin", authentication.authenticate('linkedin')

  server.get "#{prefix}linkedin/callback", (req, res, next) ->
    authentication.authenticate('linkedin', (err, user) ->
      # Successful authentication, save to session
      req.logIn user, -> 
      res.redirect '/m'
    ) req, res, next
