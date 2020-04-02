//
//  UseDefaultHelper.swift
//  MusicApp
//
//  Created by admin on 22/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import UIKit

private enum UserDefaultHelperKey: String {
    case regionCode = "regionCode"
    case gradientColor = "gradientColor"
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
    
    var gradientColor: [UIColor]! {
        get {
            let value = get(key: .gradientColor) as? [UIColor] ?? AppConstant.colors[0]
            return value
        }
        set(gradientColor) {
            save(value: gradientColor, key: .gradientColor)
        }
    }
}

extension UserDefaultHelper {
    private func save(value: Any?, key: UserDefaultHelperKey) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: value as Any, requiringSecureCoding: false)
            userDefaultManager.set(data, forKey: key.rawValue)
            userDefaultManager.synchronize()
        } catch {
            print("Error")
        }
    }

    private func get(key: UserDefaultHelperKey) -> Any? {
        if let data = userDefaultManager.data(forKey: key.rawValue) {
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        } else {
            return nil
        }
    }
}
