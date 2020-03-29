//
//  LanguageHelper.swift
//  MusicApp
//
//  Created by admin on 29/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

let APPLE_LANGUAGE_KEY = "AppLanguages"

enum LanguageType: String {
    case vietnam = "vi"
    case english = "en"
}

class LanguageHelper {
    
    //get current apple language
    class func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        if let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as? NSArray {
            return langArray.firstObject as! String
        }
        return "en"
    }
    
    class func changeLanguage() {
        if LanguageHelper.currentAppleLanguage() == "en" {
            LanguageHelper.setAppleLAnguageTo(lang: LanguageType.vietnam)
        } else {
            LanguageHelper.setAppleLAnguageTo(lang: LanguageType.english)
        }
    }
    
    class func currentAppleLanguageFull() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    class func currentLanguageStr() -> String {
        switch currentAppleLanguage() {
        case LanguageType.vietnam.rawValue:
            return "Tiếng Việt"
        default:
            return "English"
        }
    }
    
    // set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: LanguageType) {
        let userdef = UserDefaults.standard
        userdef.set([lang.rawValue,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
        Bundle.setLanguage(lang.rawValue)
    }
    
    class func getCurrentBundle() -> Bundle {
        let currentLanguage = LanguageHelper.currentAppleLanguage()
        if let _path = Bundle.main.path(forResource: LanguageHelper.currentAppleLanguageFull(), ofType: "lproj") {
            return Bundle(path: _path)!
        } else
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                return Bundle(path: _path)!
            } else {
                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                return  Bundle(path: _path)!
        }
    }
}
