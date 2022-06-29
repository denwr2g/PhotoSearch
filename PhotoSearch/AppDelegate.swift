//
//  AppDelegate.swift
//  PhotoSearch
//
//  Created by deniss.lobacs on 16/05/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = makeViewController()
        
        return true
    }

    func makeViewController() -> UIViewController {
        let vc = ViewController()
        let vm = ViewModel()
        
        vc.configure(viewModel: vm)
        
        return vc
    }
}

