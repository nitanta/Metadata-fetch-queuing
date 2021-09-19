//
//  SceneDelegate.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        addNewRoot()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}


extension SceneDelegate {
    /// Make a new root controller providing the necessary details
    private func addNewRoot() {
        let listViewController = ListingViewController.initialize(.main)
        listViewController.viewModel = ListingViewModel(service: MetadataFetchService())
        
        let navigationController = UINavigationController(rootViewController: listViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}



