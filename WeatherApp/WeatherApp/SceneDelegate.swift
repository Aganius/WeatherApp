//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 6/03/22.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private var navigationController: UINavigationController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let store = WeatherStore(service: .init())
            let viewModel = WeatherControlsViewModel()
            window.rootViewController = UIHostingController(
                rootView: WeatherControlsView(viewModel: viewModel).environmentObject(store)
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
