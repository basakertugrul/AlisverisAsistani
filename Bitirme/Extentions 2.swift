//
//  Extentions.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 30.04.2021.
//

import Foundation

extension UserDefaults {

    private enum Keys {

        static let token = "token"

    }

    class var myKey: Bool {
        get {
            return UserDefaults.standard.String(forKey: Keys.token)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.token)
        }
    }

}
