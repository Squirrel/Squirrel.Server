# Squirrel Server

This rack application implements the server side component for
[Squirrel.Mac](https://github.com/Squirrel/Squirrel.Mac). It is Heroku
compatible and should get you started setting up your own Squirrel server.

# Deploying the server

1. Run script/setup and follow the prompts.
1. Install the [Herkou Toolbelt](https://toolbelt.heroku.com).
1. Run script/heroku-deploy to create the app on Heroku, configure the
environment, push the code and open the admin interface in your browser!

# Configuring your client

Once you've deployed your sever, you need to configure a client to query it for
updates.

The update resource is `/latest`, so set your `SQRLUpdater.updateRequest` to
`[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://my-server.herokuapp.com/latest"]]`.
