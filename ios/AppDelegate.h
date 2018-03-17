// AppDelegate.h boilerplate

#import <UIKit/UIKit.h>
//#import GCDWebServer/GCDWebUploader.h"
#import "GCDWebServer/GCDWebUploader.h"
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    GCDWebUploader* _webUploader;
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
