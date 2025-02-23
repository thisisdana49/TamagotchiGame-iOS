//
//  AppStorage.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    
    private let key: String
    private let defaultValue: T
    private let defaults = UserDefaults.standard

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get { defaults.object(forKey: key) as? T ?? defaultValue }
        set { defaults.set(newValue, forKey: key) }
    }
    
}
