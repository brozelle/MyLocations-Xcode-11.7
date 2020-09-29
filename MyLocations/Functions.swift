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
