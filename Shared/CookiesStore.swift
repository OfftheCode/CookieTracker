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
    func add(cookies amount: Int)
    
    var cookiesAmountDidChange: ((Int) -> Void)? { get set }
}

public class CookiesStore: NSObject, CookiesStorable {
    
    public static let MIN_COOKIES_AMOUNT = 0
    public static let MAX_COOKIES_AMOUNT = 15
    
    private let defaults: UserDefaults
    
    var cookiesAmount: Int {
        defaults.getCookiesAmount()
    }
    
    private var _cookiesAmount: Int {
        didSet {
            guard Self.MIN_COOKIES_AMOUNT...Self.MAX_COOKIES_AMOUNT ~= cookiesAmount else { _cookiesAmount = oldValue; return }
            defaults.setCookiesAmount(to: _cookiesAmount)
            cookiesAmountDidChange?(cookiesAmount)
        }
    }
    
    public init(defaults: UserDefaults = UserDefaults(suiteName: "group.com.infullmobile.cookietracker") ?? .standard) {
        self.defaults = defaults
        _cookiesAmount = defaults.getCookiesAmount()
    }
    
    public func eatCookie() {
        _cookiesAmount -= 1
    }
    
    public func add(cookies amount: Int) {
        _cookiesAmount += amount
    }
    
    /// Runs when cookies amount did change won't be trigger if tried to set same value twice
    public var cookiesAmountDidChange: ((Int) -> Void)?
    
}

private extension UserDefaults {
    
    func getCookiesAmount() -> Int {
        if let value = value(forKey: .kCookiesAmount) as? Int {
            return value
        } else {
            return CookiesStore.MAX_COOKIES_AMOUNT / 2
        }
    }
    
    func setCookiesAmount(to value: Int) {
        setValue(value, forKey: .kCookiesAmount)
    }
    
}

private extension String {
    static let kCookiesAmount: String = "cookies.amount"
}
