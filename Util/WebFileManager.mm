//
//  WebFileManager.cpp
//  PPSSPP
//
//  Created by WinsonWu on 17/3/2018.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "WebFileManager.h"

#include <string>
#import "GCDWebServer/GCDWebUploader.h"

#include "ShareInfo.h"

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
        NSString *url=[[_webUploader serverURL] absoluteString];
        return [url UTF8String];
    }
    
    void WebFileManager::Start(){
        NSString *productName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
        for(int i=8080;i<=9000;i++){
            if([_webUploader startWithPort:i bonjourName:productName]){
                break;
            }
        }
        NSString *url=[[_webUploader serverURL] absoluteString];
        
        util::ShareInfo::Instance().Set("WebFileManagerUrl", std::string([url UTF8String]));
        
    }
    void WebFileManager::Stop(){
        [_webUploader stop];
    }
}
