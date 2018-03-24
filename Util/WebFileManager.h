//
//  WebFileManager.hpp
//  PPSSPP
//
//  Created by WinsonWu on 17/3/2018.
//

#ifndef WebFileManager_hpp
#define WebFileManager_hpp

#import <stdio.h>
#import <string>

namespace util {
    class WebFileManager {
        public:
            virtual std::string GetUrl();
            virtual void Start();
            virtual void Stop();
            virtual bool IsRunning();
            virtual void ShowView();
            WebFileManager();
    };
}
#endif /* WebFileManager_hpp */
