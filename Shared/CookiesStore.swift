//
//  CookiesStore.swift
//  Cookie Tracker
//
//  Created by Piotr Szadkowski on 17/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation

protocol CookiesStorable: class {
    var cookiesAmount: Int { get }
    func eatCookie()
    
    var cookiesAmountDidChange: ((Int) -> Void)? { get set }
}

public class CookiesStore: NSObject, CookiesStorable {
    
    public static let MIN_COOKIES_AMOUNT = 0
    public static let MAX_COOKIES_AMOUNT = 10
    
    private let defaults: UserDefaults
    
    private(set) var cookiesAmount: Int {
        didSet {
            guard Self.MIN_COOKIES_AMOUNT...Self.MAX_COOKIES_AMOUNT ~= cookiesAmount else { cookiesAmount = oldValue; return }
            defaults.setCookiesAmount(to: cookiesAmount)
            cookiesAmountDidChange?(cookiesAmount)
        }
    }
    
    public init(defaults: UserDefaults = UserDefaults(suiteName: "group.com.infullmobile.cookietracker") ?? .standard) {
        self.defaults = defaults
        cookiesAmount = defaults.getCookiesAmount()
    }
    
    public func eatCookie() {
        cookiesAmount -= 1
    }
    
    /// Runs when cookies amount did change won't be trigger if tried to set same value twice
    public var cookiesAmountDidChange: ((Int) -> Void)?
    
}

private extension UserDefaults {
    
    func getCookiesAmount() -> Int {
        if let value = value(forKey: .kCookiesAmount) as? Int {
            return value
        } else {
            return CookiesStore.MAX_COOKIES_AMOUNT
        }
    }
    
    func setCookiesAmount(to value: Int) {
        setValue(value, forKey: .kCookiesAmount)
    }
    
}

private extension String {
    static let kCookiesAmount: String = "cookies.amount"
}
