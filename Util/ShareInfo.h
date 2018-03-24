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
    typedef std::function<void(std::string)> ButtonBarLabelUpdateCallback;
    
    class ShareInfo {
    public:
        static ShareInfo& Instance();
        std::string Get(std::string key);
        void Set(std::string key, std::string value);
        WebFileManager* GetWebFileManager();
        void SetWebFileManager(WebFileManager *webFileManager);
        
        void UpdateButtonBarLabel(std::string label);
        void SetUpdateButtonBarLabelDelegate(ButtonBarLabelUpdateCallback callback);
    private:
        ShareInfo();
        std::map<std::string, std::string> TStrStrMap;
        WebFileManager *_webFileManager;
        ButtonBarLabelUpdateCallback buttonBarLabelUpdateCallback;
    };
}
#endif /* ShareInfo_hpp */
