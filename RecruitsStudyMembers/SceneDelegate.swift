//
//  SceneDelegate.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
//        UserDefaultsManager.token = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImQ3YjE5MTI0MGZjZmYzMDdkYzQ3NTg1OWEyYmUzNzgzZGMxYWY4OWYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc2VzYWMtMSIsImF1ZCI6InNlc2FjLTEiLCJhdXRoX3RpbWUiOjE2NjgzMzA1MjcsInVzZXJfaWQiOiJRV1M4eEZsa0lPZjlHUU1wYVFwV0pCa2hXOWUyIiwic3ViIjoiUVdTOHhGbGtJT2Y5R1FNcGFRcFdKQmtoVzllMiIsImlhdCI6MTY2ODMzMDUyNywiZXhwIjoxNjY4MzM0MTI3LCJwaG9uZV9udW1iZXIiOiIrODIxMDMyNjMxNTE1IiwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJwaG9uZSI6WyIrODIxMDMyNjMxNTE1Il19LCJzaWduX2luX3Byb3ZpZGVyIjoicGhvbmUifX0.Ba18TwG4oQUlxU6vg-ZYGzIrrpfl-fGejpSzGBPBlWAst3tVGGZGHC6EqujsXZtFJ-xiI4pH2K2HAcPdQ1Qz3bgF5Zq3kB8tfQMoz1HdD7KCEU4OjTcIfjbK4v7wTqGqzIDYtiHCA7-AdMtwaAiEPEzSovnlBS1NS4Opy3_reC-9gsntOEALWtGgkDp8ki0YcefpIaD8gteF_yXLt3VfzCgxyd8q-LytkywBcXOlxMS8tCrTgAPhppjl4Gn__vQFxWMP5ExA62LVDQfdzxxUkldLJt48IToZ9ilvcKTdAbWM6mvl34j-WzY3PpsVvFS17Pi-2HKSIvkPNIr1saLGPQ"
        
//        let vc = !UserDefaultsManager.certiNum.isEmpty ? GenderViewController() : SplashViewController()
        let vc = MainTabBarController()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = vc
        
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

