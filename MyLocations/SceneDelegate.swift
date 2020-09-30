//
//  SceneDelegate.swift
//  MyLocations
//
//  Created by Buck Rozelle on 9/26/20.
//  Copyright © 2020 buckrozelledotcomLLC. All rights reserved.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    //Code that loads the data and connects it to a SQLite data source.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores {
            (storeDescription, error)
            in
            if let error = error {
                fatalError("Could not load data store: \(error)")
            }
        }
        
        return container
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        let tabController = window!.rootViewController as! UITabBarController
        
        if let tableViewControllers = tabController.viewControllers {
            let navController = tableViewControllers[0] as! UINavigationController
            let controller = navController.viewControllers.first as! CurrentLocationViewController
            controller.managedObjectContext = managedObjectContext
            listenForFatalCoreDataNotifications()
        }
        //guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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
    
    // MARK:- Helper Methods
    func listenForFatalCoreDataNotifications() {
        
        // 1 I want to be notified whenever a CoreDataSaveFailedNotification is posted.
        NotificationCenter.default.addObserver(forName: CoreDataSaveFailedNotification,
                                               object: nil, queue: OperationQueue.main,
                                               using: { notification in
            // 2 Sets up the error message to display
                                                let message = """
There was a fatal error in the app and it cannot continue. Press OK to terminate the app. Sorry for the inconvenience.
"""
            // 3 Creates a UIAlert Controller to show the message.
            let alert = UIAlertController(title: "Internal Error",
                                          message: message,
                                          preferredStyle: .alert)
            // 4 Adds an action for the alert's ok button.
            let action = UIAlertAction(title: "OK",
                                       style: .default) { _ in
            let exception = NSException(name: NSExceptionName.internalInconsistencyException,
                                        reason: "Fatal Core Data error",
                                        userInfo: nil)
                                        exception.raise()
                }
            alert.addAction(action)
            
            // 5 Show the alert.
            let tabController = self.window!.rootViewController!
            tabController.present(alert, animated: true,
                                  completion: nil)
                                                
        })
        
    }
}

