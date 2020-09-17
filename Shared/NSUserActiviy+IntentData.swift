//
//  NSUserActiviy+IntentData.swift
//  CookieKit
//
//  Created by Piotr Szadkowski on 17/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation
import Intents

extension NSUserActivity {
    
    public static let viewMyCookiesActivityType = "com.offthecode.cookietracker.viewmycookies"
    
    public static var viewMyCookiesActivity: NSUserActivity {
        let userActivity = NSUserActivity(activityType: viewMyCookiesActivityType)
        
        userActivity.title = "View my Cookies"
        userActivity.persistentIdentifier = NSUserActivityPersistentIdentifier(NSUserActivity.viewMyCookiesActivityType)
        userActivity.isEligibleForPrediction = true
        userActivity.isEligibleForSearch = true
        
        userActivity.suggestedInvocationPhrase = "View my Cookies"
        
        return userActivity
    }
    
}
