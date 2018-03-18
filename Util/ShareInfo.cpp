//
//  ShareInfo.cpp
//  PPSSPP
//
//  Created by WinsonWu on 18/3/2018.
//

#include "ShareInfo.h"

namespace util {
    
    //typedef std::pair<std::string, std::string> TStrStrPair;
    
    ShareInfo& ShareInfo::Instance(){
        static ShareInfo instance;
        return instance;
    }
    
    
    ShareInfo::ShareInfo(){
        
    }

    std::string ShareInfo::Get(std::string key){
       std::string  val= TStrStrMap[key];
        return val;
    }
    
    void ShareInfo::Set(std::string key, std::string value){
        //TStrStrMap.insert(TStrStrPair(key,value));
        TStrStrMap[key]=value;
    }
    
    WebFileManager* ShareInfo::GetWebFileManager(){
        return this->_webFileManager;
    }
    void ShareInfo::SetWebFileManager(WebFileManager *_webFileManager){
        this->_webFileManager=_webFileManager;
    }
}
