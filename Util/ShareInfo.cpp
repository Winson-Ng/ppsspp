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
    
    
    void ShareInfo::UpdateButtonBarLabel(std::string label){
        if(this->buttonBarLabelUpdateCallback!=0){
            this->buttonBarLabelUpdateCallback(label);
        }
    }
    void ShareInfo::SetUpdateButtonBarLabelDelegate(ButtonBarLabelUpdateCallback callback){
        this->buttonBarLabelUpdateCallback=callback;
    }
    
//    UI::TextView* ShareInfo::GetBottomBarTextView(){
//        if(this->_textView==nullptr){
//            _textView=new UI::TextView("", 4, false);
//        }
//        return _textView;
//    }
//    
//    void ShareInfo::SetBottomBarLabel(std::string label){
//        UI::TextView *textview=this->GetBottomBarTextView();
//        textview->SetText(label);
//    }
}
