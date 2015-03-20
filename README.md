# FFLettingYouKnow

`FFLettingYouKnow` is a library for developers who want to support `UIAlertView` in iOS 7 and `UIAlertController` in iOS 8 without making separate, conditional calls for separate iOS versions; one call, that's all. This library is an easy-to-use wrapper for those two classes, abstracting away all such iOS version conditionalization. `FFLettingYouKnow` uses appropriate alert class depending on system version automatically.

*How to Use*

First, you need to get `FFAlertClient` object. It's highly recommended to use shared singleton object provided by library. Example:

```objective-c
FFAlertClient *client = [FFAlertClient sharedAlertClientWithTitle:@"Some title"
                                                          message:@"The message"
                                                cancelButtonTitle:@"Ok"];
```

Now you have an alert client with custom title, message and cancel button. Let's present it via simple instruction:

```objective-c
[client showWithCompletion:^(BOOL isCancelled)
{
}];
```

That's all that you need to present simple alert with one button. If you need more buttons, you can easily add them to the client:

```objective-c
FFAlertClient *client = [FFAlertClient sharedAlertClientWithTitle:@"Some title"
                                                          message:@"The message"
                                                cancelButtonTitle:@"Ok"];

FFAlertButton *secondButton = [[FFAlertButton alloc] initWithTitle:@"Second action"
tapHandler:^
{
    NSLog(@"Second button tapped");
}];

[client addButton:secondButton];

[client showWithCompletion:^(BOOL isCancelled)
{
}];
```

Now you'll get an alert with two buttons with `Ok` and `Second action` titles.
