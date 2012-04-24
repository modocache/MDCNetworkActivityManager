# MDCNetworkActivityManager [![endorse](http://api.coderwall.com/modocache/endorsecount.png)](http://coderwall.com/modocache)

A singleton class which manages requests to UIApplication's
network activity indicator, allowing the user to increment/decrement
requests to display it in a thread-safe way.

## Usage

    // Request that the indicator be displayed.
    [[MDCNetworkActivityManager defaultManager] requestIndicator];

    // Release the request on the indicator.
    // If the total number of requests is below zero, the indicator
    // is hidden.
    [[MDCNetworkActivityManager defaultManager] releaseIndicator];

Check out the sample application for an example.

## License

MIT-license. Use it as you please.
