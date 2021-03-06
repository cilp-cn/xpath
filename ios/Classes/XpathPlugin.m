#import "XpathPlugin.h"
#if __has_include(<xpath/xpath-Swift.h>)
#import <xpath/xpath-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "xpath-Swift.h"
#endif

@implementation XpathPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftXpathPlugin registerWithRegistrar:registrar];
}
@end
