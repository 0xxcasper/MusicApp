//
//  UseDefaultHelper.swift
//  MusicApp
//
//  Created by admin on 22/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

private enum UserDefaultHelperKey: String {
    case regionCode = "regionCode"
}

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    private let userDefaultManager = UserDefaults.standard

    var regionCode: String? {
        get {
            let value = get(key: .regionCode) as? String
            return value
        }
        set(regionCode) {
            save(value: regionCode, key: .regionCode)
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
}
