//
//  HomeViewController.swift
//  Cookie Tracker
//
//  Created by Piotr Szadkowski on 17/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit
import Intents
import IntentsUI

import CookieKit

class HomeViewController: UIViewController {
    
    // MARK: Properties
    
    private let store: CookiesStorable
    
    private let viewCookiesShorcut: INShortcut? = {
        let intent = ViewMyCookiesIntent()
        intent.suggestedInvocationPhrase = "View my Cookies"
        return INShortcut(intent: intent)
    }()
    
    private let eatCookieShorcut: INShortcut? = {
        let intent = AddCookieIntent()
        intent.suggestedInvocationPhrase = "Add a Cookie"
        return INShortcut(intent: intent)
    }()
    
    // MARK: Subviews
    
    var homeView: HomeView { view as! HomeView }
    
    // MARK: Init
    
    init(store: CookiesStorable) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    // MARK: View Lifecycle
    
    override func loadView() {
        view = HomeView(eatCookieAction: { [unowned self] in
            self.eatCookie()
        }, showMyCookiesAction: { [unowned self] in
            self.viewMyCookies()
        }, addViewMyCookiesToSiriAction: { [unowned self] in
            self.addShowCookiesSiriShorcut()
        }, addEatCookieToSiriAction: { [unowned self] in
            self.addEatCookieSiriShorcut()
        })
        
        homeView.viewCookiesShortcut = viewCookiesShorcut
        homeView.eatCookieShortcut = eatCookieShorcut
    }
    
    override func viewDidLoad() {
        title = "Cookiez"
    }
    
    // MARK: Actions
    
    private func eatCookie() {
        store.eatCookie()
    }
    
    private func viewMyCookies() {
        navigationController?.pushViewController(CookieViewController(store: store), animated: true)
    }
    
    private func addShowCookiesSiriShorcut() {
        guard let shorcut = viewCookiesShorcut else { return }
        let shortcutViewController = INUIAddVoiceShortcutViewController(shortcut: shorcut)
        shortcutViewController.delegate = self
        present(shortcutViewController, animated: true)
    }
    
    private func addEatCookieSiriShorcut() {
        guard let shorcut = eatCookieShorcut else { return }
        let shortcutViewController = INUIAddVoiceShortcutViewController(shortcut: shorcut)
        shortcutViewController.delegate = self
        present(shortcutViewController, animated: true)
    }
    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        super.restoreUserActivityState(activity)
        
        if activity.activityType == NSUserActivity.viewMyCookiesActivityType {
            viewMyCookies()
        }
    }

}

extension HomeViewController: INUIAddVoiceShortcutViewControllerDelegate {
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true)
    }
    
    
}
