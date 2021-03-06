#import "EnvironmentChecker.h"

@implementation EnvironmentChecker

NSMutableDictionary* cache_;

+ (void) initialize
{
  cache_ = [NSMutableDictionary new];
}

+ (BOOL) checkDoubleCommand
{
  // If DoubleCommand was installed, return YES even if it removed.
  NSString* cachekey = @"DoubleCommand";
  if ([cache_ objectForKey:cachekey]) {
    return YES;
  }

  {
    NSArray* paths = @[ @"/Library/StartupItems/DoubleCommand" ];
    for (NSString* path in paths) {
      if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [cache_ setObject:[NSNumber numberWithBool:YES] forKey:cachekey];
        return YES;
      }
    }
  }

  return NO;
}

+ (BOOL) checkSmoothMouse
{
  // If SmoothMouse was installed, return YES even if it removed.
  NSString* cachekey = @"SmoothMouse";
  if ([cache_ objectForKey:cachekey]) {
    return YES;
  }

  {
    NSArray* paths = @[ @"/System/Library/Extensions/SmoothMouse.kext",
                        @"/Library/PreferencePanes/SmoothMouse.prefPane" ];
    for (NSString* path in paths) {
      if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [cache_ setObject:[NSNumber numberWithBool:YES] forKey:cachekey];
        return YES;
      }
    }
  }

  return NO;
}

@end
