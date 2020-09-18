//
//  EatCookieIntentHandler.swift
//  CookieKit
//
//  Created by Piotr Szadkowski on 18/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit
import Intents

public class CreateCookieIntentHandler: NSObject, AddCookieIntentHandling {
    
    public func resolveCookiesAmount(for intent: AddCookieIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if intent.cookiesAmount == "" || intent.cookiesAmount == nil {
            completion(INStringResolutionResult.needsValue())
        } else {
            completion(.success(with: intent.cookiesAmount ?? ""))
        }
    }
    
    public func handle(intent: AddCookieIntent, completion: @escaping (AddCookieIntentResponse) -> Void) {
        completion(.success(amount: String(CookiesStore().cookiesAmount)))
    }

    public func confirm(intent: AddCookieIntent, completion: @escaping (AddCookieIntentResponse) -> Void) {
        completion(.init(code: .ready, userActivity: nil))
    }
}
