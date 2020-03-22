//
//  UseDefaultHelper.swift
//  MusicApp
//
//  Created by admin on 22/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

private enum UserDefaultHelperKey: String {
    case fcmToken = "FcmToken"
    case loginUserInfo = "LoginUserInfo"
    case userToken = "UserToken"
    case launchedBefore = "launchedBefore"
}

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    private let userDefaultManager = UserDefaults.standard

    var userToken: String? {
        get {
            let value = get(key: .userToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .userToken)
        }
    }
    
    var fcmToken: String? {
        get {
            let value = get(key: .fcmToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .fcmToken)
        }
    }
    
    var launchedBefore: Bool? {
        get {
            let value = get(key: .launchedBefore) as? Bool
            return value
        }
        set(launchedBefore) {
            save(value: launchedBefore, key: .launchedBefore)
        }
    }
}

extension UserDefaultHelper {
    private func save(value: Any?, key: UserDefaultHelperKey) {
        userDefaultManager.set(value, forKey: key.rawValue)
        userDefaultManager.synchronize()
    }

    private func get(key: UserDefaultHelperKey) -> Any? {
        return userDefaultManager.object(forKey: key.rawValue)
    }
    
    func clearUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaultHelperKey.userToken.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultHelperKey.loginUserInfo.rawValue)
        UserDefaults.standard.synchronize()
    }
}
