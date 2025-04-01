//
//  SpotifyCloneApp.swift
//  SpotifyClone
//
//  Created by Natalia Ogorek on 28.03.25.
//

import SwiftUI
import SwiftfulRouting

@main
struct SpotifyCloneApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
