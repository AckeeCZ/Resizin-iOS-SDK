//
//  Constants.swift
//  ResizinExample
//
//  Created by Jakub Olejník on 14/02/2018.
//  Copyright © 2018 Ackee. All rights reserved.
//

import Resizin

enum Constants {
    static let imageKey = "ackee"
    static let imageSize = CGSize(width: 300, height: 225)
    static var resizinSize: ResizinSize { return ResizinSize(cgSize: imageSize, scale: Int(UIScreen.main.scale)) }
}
