# Squirrel Server

This rack application implements the server side component for
[Squirrel.Mac](https://github.com/Squirrel/Squirrel.Mac). It is Heroku
compatible and should get you started setting up your own Squirrel server.

Updates are read from `db/releases.json` which is a JSON array of Squirrel
releases. Add your releases to this file before running or deploying.

# Deploying the server

1. Run `script/bootstrap`.
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
NSString *bundleVersion = [NSBundle.mainBundle objectForInfoDictionaryKey:(id)kCFBundleVersionKey];
NSString *URLString = [NSString stringWithFormat:@"http://my-server.herokuapp.com/releases/latest?version=%@", [bundleVersion stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
NSURL *URL = [NSURL URLWithString:URLString];
self.updater = [[SQRLUpdater alloc] initWithUpdateRequest:[NSURLRequest requestWithURL:URL]];
```

# Running locally

Run `script/server` to start, set your update URL request host to
`localhost:9393` for testing.
