//
//  IntentViewController.swift
//  ViewCookiesUI
//
//  Created by Piotr Szadkowski on 18/09/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import IntentsUI
import CookieKit

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    lazy var cookiesSummaryView: CookiesSummaryView = {
        let view = CookiesSummaryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    // MARK: - INUIHostedViewControlling
    
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        
        guard interaction.intentHandlingStatus == .success, let response = interaction.intentResponse as? ViewMyCookiesIntentResponse else {
            completion(false, parameters, self.desiredSize)
            return
        }
        
        view.addSubview(cookiesSummaryView)
        
        NSLayoutConstraint.activate([
            cookiesSummaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cookiesSummaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cookiesSummaryView.topAnchor.constraint(equalTo: view.topAnchor),
            cookiesSummaryView.heightAnchor.constraint(equalToConstant: CookiesSummaryView.suggestedHeight)
        ])
        
        let amount = Int(response.amount ?? "0") ?? 0
        cookiesSummaryView.configure(withCookiesAmount: amount)
        
        cookiesSummaryView.setNeedsLayout()
        cookiesSummaryView.layoutIfNeeded()
        
        completion(true, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}
