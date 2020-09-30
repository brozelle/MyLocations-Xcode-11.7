//
//  Functions.swift
//  MyLocations
//
//  Created by Buck Rozelle on 9/29/20.
//  Copyright © 2020 buckrozelledotcomLLC. All rights reserved.
//

import Foundation

func afterDelay(_ seconds: Double, run: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: run)
 
}

   
    let applicationDocumentsDirectory: URL = {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
}()

let CoreDataSaveFailedNotification = Notification.Name("CoreDataSavedFailedNotificaiton")

func fatalCoreDataError(_ error: Error) {
    print("*** Fatal Error: \(error)")
    NotificationCenter.default.post(name: CoreDataSaveFailedNotification, object: nil)
}
