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

#include <string>
#import "GCDWebServer/GCDWebUploader.h"

//#include "ShareInfo.h"

#import "ios/Reachability.h"

    
GCDWebFileManager::GCDWebFileManager():util::WebFileManager(){
        NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    
    std::string GCDWebFileManager::GetUrl(){
        
        if([_webUploader isRunning]){
            NSString *url=[[_webUploader serverURL] absoluteString];
            return std::string([url UTF8String]);
        }else if([_reachability currentReachabilityStatus] != ReachableViaWiFi){
            return "Please connect WIFI and restart app!";
        }else{
            return "WebServer not running, please restart app!";
        }
    }
    
    void GCDWebFileManager::Start(){
        
        [_reachability startNotifier];
        
        NetworkStatus status = [_reachability currentReachabilityStatus];
        
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
            
           //util::ShareInfo::Instance().Set("WebFileManagerUrl", this->GetUrl());
        }
        else
        {
           //util::ShareInfo::Instance().Set("WebFileManagerUrl", "Please change to WIFI network!");
        }
        
    }
    void GCDWebFileManager::Stop(){
        [_webUploader stop];
    }

