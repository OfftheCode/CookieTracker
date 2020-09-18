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
    private let shorcut: INShortcut? = {
        let intent = ViewMyCookiesIntent()
        intent.suggestedInvocationPhrase = "View my Cookies"
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
            }, addToSiriAction: { [unowned self] in
            self.addSiriShorct()
        })
        homeView.shorcut = shorcut
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
    
    private func addSiriShorct() {
        guard let shorcut = shorcut else { return }
        let shorcutViewController = INUIAddVoiceShortcutViewController(shortcut: shorcut)
        shorcutViewController.delegate = self
        present(shorcutViewController, animated: true)
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
