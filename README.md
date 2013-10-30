# Squirrel Server

This [Rack](http://rack.github.io) application implements the server side
component for [Squirrel.Mac](https://github.com/Squirrel/Squirrel.Mac). It is
Heroku compatible and should get you started setting up your own Squirrel
server.

# Bootstrap

Updates are read from `db/releases.json` which is a JSON array of Squirrel
releases. Add your releases to this file *before* running or deploying.

# Running locally

1. Run `script/bootstrap`.
1. Run `script/server`

The updates are served locally for testing, to use your local server set your
update URL host to `localhost:9393` for testing, see
[Configuring your client](#configuring-your-client).

# Deploying the server

1. Install the [Herkou Toolbelt](https://toolbelt.heroku.com).
1. Run `script/heroku-deploy` to create the app on Heroku and push the code.

# Configuring your client

Once you've deployed your sever, you need to configure a client to query it for
updates.

The example server compares a `version` query parameter to determine whether an
update is required.

The update resource is `/releases/latest`, configure your client
`SQRLUpdater.updateRequest`:

```objc
NSString *bundleVersion = NSBundle.mainBundle.sqrl_bundleVersion;

// Set this to @"localhost:9393" to use the local server
NSString *host = @"my-server.herokuapp.com";

NSString *URLString = [NSString stringWithFormat:@"http://%@/releases/latest?version=%@", host, [bundleVersion stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
NSURL *URL = [NSURL URLWithString:URLString];

self.updater = [[SQRLUpdater alloc] initWithUpdateRequest:[NSURLRequest requestWithURL:URL]];
```
