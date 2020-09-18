//
//  ViewMyCookiesIntentHandler.swift
//  Cookie Tracker
//
//  Created by Piotr Szadkowski on 18/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

public class ViewMyCookiesIntentHandler: NSObject, ViewMyCookiesIntentHandling {
    
    public func handle(intent: ViewMyCookiesIntent, completion: @escaping (ViewMyCookiesIntentResponse) -> Void) {
        completion(.init(code: .success, userActivity: nil))
    }
    
    public func confirm(intent: ViewMyCookiesIntent, completion: @escaping (ViewMyCookiesIntentResponse) -> Void) {
        completion(.init(code: .ready, userActivity: nil))
    }
}
