//
//  WebFileManager.cpp
//  PPSSPP
//
//  Created by WinsonWu on 17/3/2018.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

#import "Util/WebFileManager.h"
#import "GCDWebFileManager.h"

#import <string>
#import "GCDWebServer/GCDWebUploader.h"
#import "FileManagerViews/FileManagerTableViewController.h"


//#import "Util/ShareInfo.h"

#import "ios/Reachability.h"

@interface ViewControllerHelper : NSObject
+(UIViewController *)currentViewController;
@end

@implementation ViewControllerHelper
+(UIViewController *)currentViewController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}
@end;


GCDWebFileManager::GCDWebFileManager():util::WebFileManager(){
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    _reachability = [Reachability reachabilityForInternetConnection];
}

void GCDWebFileManager::SetPort(NSNumber *port){
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:port forKey:@"GCDWebFileManager_Port"];
    [defaults synchronize];
}
NSNumber* GCDWebFileManager::GetPort(){
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *port=[defaults objectForKey:@"GCDWebFileManager_Port"];
    if(port==nil){
        port=@80;
        [defaults setObject:port forKey:@"GCDWebFileManager_Port"];
        [defaults synchronize];
    }
    return port;
}
std::string GCDWebFileManager::GetUrl(){
    std::string result="";
    if([_reachability currentReachabilityStatus] != ReachableViaWiFi){
        result= "Please connect WIFI";
    }else if([_webUploader isRunning]){
        NSString *url=[[_webUploader serverURL] absoluteString];
        result= std::string([url UTF8String]);
    }else{
        result= "WebServer not running";
    }
    
    //util::ShareInfo::Instance().SetBottomBarLabel( "WebFileManager: " +result);
    return result;
}

bool GCDWebFileManager::IsAutoStart(){
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *autoStart=[defaults objectForKey:@"GCDWebFileManager_AutoStart"];
    
    return [autoStart boolValue];
}

void GCDWebFileManager::SetAutoStart(bool isOn){
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:isOn] forKey:@"GCDWebFileManager_AutoStart"];
    [defaults synchronize];
}

bool GCDWebFileManager::IsRunning(){
    return [_webUploader isRunning];
}
void GCDWebFileManager::Start(){
    
    [_reachability startNotifier];
    
    NetworkStatus status = [_reachability currentReachabilityStatus];
    
    if (status == ReachableViaWiFi)
    {
        //WiFi
        NSString *productName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
        NSNumber *port=this->GetPort();
        [_webUploader startWithPort:[port intValue] bonjourName:productName];
//        if(![_webUploader startWithPort:80 bonjourName:productName]){
//            for(int i=8080;i<=9000;i++){
//                if([_webUploader startWithPort:i bonjourName:productName]){
//                    break;
//                }
//            }
//        }
        
        //util::ShareInfo::Instance().Set("WebFileManagerUrl", this->GetUrl());
    }
    else
    {
        //util::ShareInfo::Instance().Set("WebFileManagerUrl", "Please change to WIFI network!");
    }
    
}
void GCDWebFileManager::Stop(){
    if([_webUploader isRunning])
        [_webUploader stop];
}

void GCDWebFileManager::ShowView()
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        FileManagerTableViewController *view=[[FileManagerTableViewController alloc] init];
        UIViewController *topController =[ViewControllerHelper currentViewController];
        [topController presentViewController:view animated:true completion:^(){
            
        }];
    });
}

