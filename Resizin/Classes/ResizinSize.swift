//
//  ResizinSize.swift
//  Pods-Resizin_Tests
//
//  Created by Jakub Olejník on 30/11/2017.
//

import Foundation

/// Struct for defining image size and scale in points
public struct ResizinSize {
    
    /// Desired image width in points
    public let width: Int?
    
    /// Desired image height in points
    public let height: Int?
    
    /// Desired image scale
    public let scale: Int
    
    internal var modifiers: [String] {
        if let width = width, let height = height, width == height {
            return ["s_\(width * scale)"]
        }
        
        return [width.map { "w_\($0 * scale)" }, height.map { "h_\($0 * scale)" }].compactMap { $0 }
    }
    
    /// MARK: Inits
    
    /// Initializes new size struct
    ///
    /// - Parameters:
    ///   - width: Desired width of the image in points
    ///   - scale: Desired scale used to compute image size in pixels
    public init(width: Int, scale: Int) {
        self.width = width
        self.height = nil
        self.scale = scale
    }
    
    /// Initializes new size struct
    ///
    /// - Parameters:
    ///   - height: Desired height of the image in points
    ///   - scale: Desired scale used to compute image size in pixels
    public init(height: Int, scale: Int) {
        self.width = nil
        self.height = height
        self.scale = scale
    }
    
    /// Initializes new size struct
    ///
    /// - Parameters:
    ///   - width: Desired width of the image in points
    ///   - height: Desired height of the image in points
    ///   - scale: Desired scale used to compute image size in pixels
    public init(width: Int, height: Int, scale: Int) {
        self.width = width
        self.height = height
        self.scale = scale
    }
    
    /// Initializes new size struct
    ///
    /// - Parameters:
    ///   - size: Desired size of the image in points
    ///   - scale: Desired scale used to compute image size in pixels
    public init(size: Int, scale: Int) {
        self.width = nil
        self.height = nil
        self.scale = scale
    }
    
    /// Initializes new size struct
    ///
    /// - Parameters:
    ///   - cgSize: Desired size of the image in points
    ///   - scale: Desired scale used to compute image size in pixels
    public init(cgSize: CGSize, scale: Int) {
        self.width = Int(cgSize.width)
        self.height = Int(cgSize.height)
        self.scale = scale
    }
}
