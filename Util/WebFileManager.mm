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

#import "WebFileManager.h"

#include <string>
#import "GCDWebServer/GCDWebUploader.h"

#include "ShareInfo.h"

#import "ios/Reachability.h"

namespace util {
    WebFileManager& WebFileManager::Instance(){
        static WebFileManager instance;
        return instance;
    }
    
    WebFileManager::WebFileManager(){
        NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
        
    }
    
    const char* WebFileManager::GetUrl(){
        if([_webUploader isRunning]){
            NSString *url=[[_webUploader serverURL] absoluteString];
            return [url UTF8String];
        }else{
            return "WebServer not running";
        }
    }
    
    void WebFileManager::Start(){
        
        
        Reachability *reachability = [Reachability reachabilityForInternetConnection];

        [reachability startNotifier];
        
        NetworkStatus status = [reachability currentReachabilityStatus];
        
        if (status == ReachableViaWiFi)
        {
            //WiFi
            NSString *productName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
            if(![_webUploader startWithPort:80 bonjourName:productName]){
                for(int i=8080;i<=9000;i++){
                    if([_webUploader startWithPort:i bonjourName:productName]){
                        break;
                    }
                }
            }
            
            util::ShareInfo::Instance().Set("WebFileManagerUrl", this->GetUrl());
        }
        else
        {
           util::ShareInfo::Instance().Set("WebFileManagerUrl", "Please change to WIFI network!");
        }
        
    }
    void WebFileManager::Stop(){
        [_webUploader stop];
    }
}
