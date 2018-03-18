//
//  ShareInfo.hpp
//  PPSSPP
//
//  Created by WinsonWu on 18/3/2018.
//

#ifndef ShareInfo_hpp
#define ShareInfo_hpp

#include <stdio.h>
#include <string>
#include <map>
#import "WebFileManager.h"

namespace util {
    class ShareInfo {
    public:
        static ShareInfo& Instance();
        std::string Get(std::string key);
        void Set(std::string key, std::string value);
        WebFileManager* GetWebFileManager();
        void SetWebFileManager(WebFileManager *webFileManager);
    private:
        ShareInfo();
        std::map<std::string, std::string> TStrStrMap;
        WebFileManager *_webFileManager;
    };
}
#endif /* ShareInfo_hpp */
