//
//  ImageReference.swift
//  Resizin
//
//  Created by Josef Dolezal on 10/07/2017.
//  Copyright © 2017 Ackee. All rights reserved.
//

import Foundation

/// Uploaded image reference
public struct ImageReference {
    /// Image identifier
    let ID: Int
    /// Image key for API calls
    let key: String
    /// Image size
    let size: String
    /// Image mime type
    let mimeType: String
    /// Uploader client ID
    let clientID: Int
    /// Time when the image was updated
    let updateTime: String

    init?(from json: [String: Any]) {
        guard
            let ID = json["id"] as? Int,
            let key = json["key"] as? String,
            let size = json["size"] as? String,
            let mimeType = json["mime_type"] as? String,
            let clientID = json["client_id"] as? Int,
            let updateTime = json["updated_at"] as? String
        else {
            return nil
        }

        self.ID = ID
        self.key = key
        self.size = size
        self.mimeType = mimeType
        self.clientID = clientID
        self.updateTime = updateTime
    }
}
