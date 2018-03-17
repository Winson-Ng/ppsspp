//
//  WebFileManager.hpp
//  PPSSPP
//
//  Created by WinsonWu on 17/3/2018.
//

#ifndef WebFileManager_hpp
#define WebFileManager_hpp

#include <stdio.h>
#include <string>
#import "GCDWebServer/GCDWebUploader.h"

namespace util {
    class WebFileManager {
        public:
            static WebFileManager& Instance();
            virtual const char* GetUrl();
            virtual void Start();
            virtual void Stop();
        private:
            WebFileManager();
            GCDWebUploader *_webUploader;
    };
}
#endif /* WebFileManager_hpp */
