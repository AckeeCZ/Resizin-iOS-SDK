//
//  Uploader.swift
//  Resizin
//
//  Created by Josef Dolezal on 11/07/2017.
//  Copyright © 2017 Ackee. All rights reserved.
//

import Foundation

/// Image uploading helper
class Uploader {
    typealias UploadResult = Result<ImageReference, ResizinError>

    /// Requests base URL
    private let baseURL: URL

    /// Unique client key
    private let clientKey: String

    /// Requests session
    private let session: URLSession

    /// Creates new instance with given configuration
    ///
    /// - Parameters:
    ///   - baseURL: Base URL for all requests
    ///   - clientKey: API client key
    ///   - configuration: Shared upload session configuration
    init(baseURL: URL, clientKey: String, configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.baseURL = baseURL
        self.clientKey = clientKey
        self.session = URLSession(configuration: configuration)
    }

    /// Uploads given image to Resizin server
    ///
    /// - Parameters:
    ///   - image: Image which will be uploaded
    ///   - name: Image name
    ///   - completion: Upload callback
    public func upload(image: UIImage, location: String, completion: ((UploadResult) -> Void)?) {
        guard let imageData = UIImagePNGRepresentation(image) else {
            completion?(.failure(.invalidImageData))
            return
        }

        let builder = RequestBuilder()
        let filename = location.components(separatedBy: "/").last ?? ""

        builder.addPart(withForm: location, name: "id")
        builder.addPart(withForm: imageData, name: "file", filename: filename, mimeType: "image/png")

        var request = builder.buildRequest(for: baseURL)

        request.addValue("Key \(clientKey)", forHTTPHeaderField: "Authorization")

        session.dataTask(with: request) { [weak self] data, response, error in
            guard let `self` = self else { return }

            completion?(self.processUploadResponse(data: data, response: response, error: error))
        }.resume()
    }

    /// Upload response processing helper
    ///
    /// - Parameters:
    ///   - data: Response data
    ///   - response: Server response
    ///   - error: Underlying request error
    /// - Returns: `ImgeReference` on success, `ResizinError` otherwise
    func processUploadResponse(data: Data?, response: URLResponse?, error: Error?) -> UploadResult {
        if let error = error {
            return .failure(.underlyingError(error))
        }

        guard
            let data = data,
            let responseBody = try? JSONSerialization.jsonObject(with: data, options: []),
            let json = responseBody as? [String: Any]
            else {
                return .failure(.unexpectedResponse)
        }

        guard let response = response as? HTTPURLResponse else {
            return .failure(.unexpectedResponse)
        }

        guard (200..<300).contains(response.statusCode) else {
            let content = json as? [String: String]

            return .failure(.invalidResponseStatusCode(response.statusCode, content))
        }

        guard let reference = ImageReference(from: json) else {
            return .failure(.unableToSerializeJSON(json))
        }
        
        return .success(reference)
    }
}
