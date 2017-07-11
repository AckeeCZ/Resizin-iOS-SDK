//
//  Result.swift
//  Resizin
//
//  Created by Josef Dolezal on 10/07/2017.
//  Copyright © 2017 Ackee. All rights reserved.
//

import Foundation

/// Action result
///
/// - success: Represnets successfull action result
/// - failure: Represents failure action result
public enum Result<Value, E: Error> {
    case success(Value)
    case failure(E)
}
