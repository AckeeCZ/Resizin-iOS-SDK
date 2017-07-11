//
//  RequstBuilder.swift
//  Resizin
//
//  Created by Josef Dolezal on 10/07/2017.
//  Copyright © 2017 Ackee. All rights reserved.
//

import Foundation

/// Multipart requests builder
class RequestBuilder {

    /// Multipart body content
    private var content = Data()

    /// Request boundary
    private let boundary = "Boundary-\(UUID().uuidString)"

    private var prefixedBoundary: String {
        return "--\(boundary)"
    }

    /// Creates request part with given file data
    ///
    /// - Parameters:
    ///   - data: Request data
    ///   - name: Form field name
    ///   - filename: The name of the uploaded file
    ///   - mimeType: Uploaded file mime-type
    func addPart(withForm data: Data, name: String, filename: String, mimeType: String) {
        let header = "\(prefixedBoundary)\r\nContent-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n"
        let body = "Content-Type: \(mimeType)\r\n\r\n"

        guard let headerData = header.data(using: .utf8) else { return }
        guard let bodyData = body.data(using: .utf8) else { return }

        content.append(headerData)
        content.append(bodyData)
        content.append(data)
    }

    /// Creates request part with given value for request
    ///
    /// - Parameters:
    ///   - form: Form field value
    ///   - name: Form field name
    func addPart(withForm form: String, name: String) {
        let body = "\(prefixedBoundary)\r\nContent-Disposition: form-data; name=\"\(name)\"\r\n\r\n\(form)\r\n"

        guard let bodyData = body.data(using: .utf8) else { return }

        content.append(bodyData)
    }

    /// Creates new POST request object with multipart format and content made with
    /// `addPart` API.
    ///
    /// - Parameter url: Request URL
    /// - Returns: New preconfigured request
    func buildRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.addValue(buildHeader(), forHTTPHeaderField: "Content-Type")

        var body = content

        if let boundaryData = "\r\n\(prefixedBoundary)--".data(using: .utf8) {
            body.append(boundaryData)
        }

        request.httpBody = body

        return request
    }

    /// Request header creation helper
    ///
    /// - Returns: Multipart request header
    private func buildHeader() -> String {
        return "multipart/form-data; boundary=\(boundary)"
    }
}
