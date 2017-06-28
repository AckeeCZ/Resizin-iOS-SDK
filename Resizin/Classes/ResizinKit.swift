//
//  ResizinKit.swift
//  ImageSDK
//
//  Created by Jan Mísař on 02.05.16.
//  Copyright © 2016 Ackee. All rights reserved.
//

import UIKit


/// Shared manager
public class ResizinManager: NSObject {
    
    
    public enum Environment {
        case production
        case custom(String)
        
        var url: String {
            switch self {
            case .production: return "https://img.resizin.com"
            case .custom(let url): return url
            }
        }
    }
    
    /// Image server URL. Change it only in very specific situations. Standard URLs for development and production is set by default.
    public var baseURL: String
    
    /// URL path component to be appended to base URL
    public var projectName: String
    
    /**
     Returns shared image manager.
     
     **You must call setupSharedManagerWithProjectName(_) before use!**
     */
    public static var sharedManager: ResizinManager {
        if let manager = _sharedManager {
            return manager
        } else {
            assertionFailure("You must initialize sharedManager with setupSharedManagerWithProjectName(_) first!")
            return ResizinManager(projectName: "", baseURL: Environment.production.url)
        }
    }
    
    /**
     Create and setup singleton instance of image manager.
     - parameter projectName: URL path component to be appended to base URL
     */
    public static func setupSharedManager(projectName: String, baseURL: String) {
        _sharedManager = ResizinManager(projectName: projectName, baseURL: baseURL)
    }
    
    /**
     Create and setup singleton instance of image manager.
     - parameter projectName: URL path component to be appended to base URL
     */
    public static func setupSharedManager(projectName: String, environment: Environment) {
        _sharedManager = ResizinManager(projectName: projectName, baseURL: environment.url)
    }
    
    /**
     Create and setup singleton instance of image manager.
     - parameter projectName: URL path component to be appended to base URL
     */
    public static func setupSharedManager(projectName: String) {
        setupSharedManager(projectName: projectName, environment: .production)
    }
    
    private static var _sharedManager: ResizinManager?
    
    public init(projectName: String, baseURL: String) {
        self.baseURL = baseURL
        self.projectName = projectName
        
        super.init()
        
        if type(of: self)._sharedManager == nil {
            type(of: self)._sharedManager = self
        }
    }
    
    
    
    /// Returns builded url for specific image and options
    ///
    /// - Parameters:
    ///   - key: id of image
    ///   - settings: specific settings for transformations
    /// - Returns: URL for desired image
    public func url(for key: String, settings: ResizinSettings = ResizinSettings()) -> URL {
        
        // "static" part of URL
        var url = URL(string: "\(baseURL)/\(projectName)/image")!
        
        // append all modifier according to given settings
        let modifiers = settings.modifiers
        
        // append modifiers to URL
        if modifiers.count > 0 {
            let modifiersString = modifiers.joined(separator: "-")
            url = url.appendingPathComponent(modifiersString)
        }
        
        return url.appendingPathComponent(key)
    }
}

