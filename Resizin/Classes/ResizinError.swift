//
//  ResizinError.swift
//  Resizin
//
//  Created by Josef Dolezal on 10/07/2017.
//  Copyright © 2017 Ackee. All rights reserved.
//

/// Resizin library errors
///
/// - invalidImageData: The image was not successfully serialized or deserialized
/// - unexpectedResponse: When server response doesn't meet requred format
/// - invalidResponseStatusCode: Invalid HTTP response status code, contains status code and server message (if available)
/// - unableToSerializeJSON: Response body is not valid JSON object
/// - underlyingError: Underlying networking error
public enum ResizinError: Error {
    case invalidImageData
    case unexpectedResponse
    case invalidResponseStatusCode(Int, [String: String]?)
    case unableToSerializeJSON([String: Any])
    case underlyingError(Error)
}
