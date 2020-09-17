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
    
    private(set) var cookiesAmount: Int {
        didSet {
            guard Self.MIN_COOKIES_AMOUNT...Self.MAX_COOKIES_AMOUNT ~= cookiesAmount else { cookiesAmount = oldValue; return }
            cookiesAmountDidChange?(cookiesAmount)
        }
    }
    
    public init(cookiesAmount: Int) {
        self.cookiesAmount = cookiesAmount
    }
    
    public func eatCookie() {
        cookiesAmount -= 1
    }
    
    /// Runs when cookies amount did change won't be trigger if tried to set same value twice
    public var cookiesAmountDidChange: ((Int) -> Void)?
    
}
