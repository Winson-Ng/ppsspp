//
//  GCDWebFileManager.h
//  PPSSPP
//
//  Created by WinsonWu on 19/3/2018.
//

#ifndef GCDWebFileManager_h
#define GCDWebFileManager_h

#import "Util/WebFileManager.h"
#import "GCDWebServer/GCDWebUploader.h"
#import "ios/Reachability.h"



class GCDWebFileManager : public util::WebFileManager
    {
    public:
        GCDWebFileManager();
        std::string GetUrl();
        void Start();
        void Stop();
        bool IsRunning();
        void ShowView();
    private:
        GCDWebUploader *_webUploader;
        Reachability *_reachability;
    };


#endif /* GCDWebFileManager_h */
