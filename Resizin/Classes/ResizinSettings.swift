//
//  ResizinSettings.swift
//  Pods
//
//  Created by Jan Mísař on 10.05.16.
//
//

/// Struct for defining all image settings.
public struct ResizinSettings {
    // MARK: Enums
    public enum CropMode: String {
        case fill
        case fit
        case pad
        case scale
        case cut
        case face
    }
    
    public enum Gravity: String {
        case north
        case south
        case east
        case west
        case center
        case northeast
        case northwest
        case southeast
        case southwest
        case face
    }
    
    public enum Filter: String {
        case grayscale
        case sharpen
        case blur
        case negative
        case edge
        case gauss
    }
    
    public enum Rotation: String {
        case up = "360"
        case left = "270"
        case right = "90"
        case down = "180"
    }
    
    public struct Border {
        let top: Int
        let left: Int
        let bottom: Int
        let right: Int
    }
    
    // MARK: Properties
    public var width: Int? = nil
    public var size: Int? = nil
    public var height: Int? = nil
    public var cropMode: CropMode? = nil
    public var gravity: Gravity? = nil
    public var filters: [Filter]? = nil
    public var quality: Int? = nil {
        didSet {
            if let quality = self.quality {
                self.quality = max(0, min(99, quality))
            }
        }
    }
    public var upscale : Bool?
    public var rotation: Rotation? = nil
    public var background: String? = nil
    public var border: Border? = nil
    public var alpha: Int = 100
    
    // MARK: Inits
    public init(width: Int? = nil, height: Int? = nil, size: Int? = nil, cropMode: CropMode? = nil, gravity: Gravity? = nil, filters: [Filter]? = nil, quality: Int? = nil, rotation: Rotation? = nil, upscale: Bool? = nil, background: String? = nil, alpha: Int = 100, border: Border? = nil) {
        self.size = size
        self.width = width
        self.height = height
        self.cropMode = cropMode
        self.gravity = gravity
        self.filters = filters
        self.quality = quality
        self.rotation = rotation
        self.upscale = upscale
        self.background = background
        self.alpha = alpha
        self.border = border
    }
    
    // MARK: Helpers
    public var modifiers : [String] {
        var modifiers: [String] = []
        
        if let size = size {
            modifiers.append("s_\(size)")
        } else {
            if let width = width { modifiers.append("w_\(width)") }
            if let height = height { modifiers.append("h_\(height)") }
        }
        if let cropMode = cropMode { modifiers.append("c_\(cropMode.rawValue)") }
        if let gravity = gravity { modifiers.append("g_\(gravity.rawValue)") }
        if let filters = filters {
            for filter in filters {
                modifiers.append("f_\(filter.rawValue)")
            }
        }
        if let quality = quality { modifiers.append("q_\(quality)") }
        if let rotation = rotation { modifiers.append("r_\(rotation.rawValue)") }
        if let upscale = upscale { modifiers.append("u_\(upscale ? 1 : 0)")}
        if let background = background { modifiers.append("bg_\(background)\(alpha)") }
        if let border = border { modifiers.append("b_\(border.top)_\(border.left)_\(border.bottom)_\(border.right)") }
        return modifiers
    }
}
