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

namespace util {
    class ShareInfo {
    public:
        static ShareInfo& Instance();
        virtual std::string Get(std::string key);
        virtual void Set(std::string key, std::string value);
    private:
        ShareInfo();
        std::map<std::string, std::string> TStrStrMap;
    };
}
#endif /* ShareInfo_hpp */
