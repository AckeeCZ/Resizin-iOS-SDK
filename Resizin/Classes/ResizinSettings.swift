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

    /// Crop mode
    ///
    /// - fill: Maintain original proportions and resize via smallest dimension, crop the largest.
    /// - fit: Mantain original proportions and resize so image fits wholly into new dimension.
    /// - pad: Maintain original proportions, padding added on top/bottom or left/right as needed (color is configurable)
    /// - scale: Scales image to fit within requested dimensions
    /// - cut: No resize, crop to gravity or x/y scale, force image to be new dimensions (squishing the image)
    /// - face: Crops photo around face
    public enum CropMode: String {
        case fill
        case fit
        case pad
        case scale
        case cut
        case face
    }

    /// Gives the priority to the desired portion of image while cropping
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

    /// Applies desired filter on the image
    public enum Filter: String {
        case grayscale
        case sharpen
        case blur
        case negative
        case edge
        case gauss
    }
    
    /// Rotates the image by selected degrees
    public enum Rotation: String {
        case up = "360"
        case left = "270"
        case right = "90"
        case down = "180"
    }
    
    /// Returns the image transformed into the selected format
    public enum OutputFormat: String {
        case jpeg
        case png
        case tiff
        case webp
    }

    /// Adds border (in pixels) to desired sides of the image
    public struct Border {
        let top: Int
        let left: Int
        let bottom: Int
        let right: Int
    }
    
    // MARK: Properties
    
    /// Desired image size in points
    public var size: ResizinSize? = nil
    
    /// CropMode
    public var cropMode: CropMode? = nil
    
    /// Gravity
    public var gravity: Gravity? = nil
    
    /// Array of filters that should be applied to the image
    public var filters: [Filter]? = nil
    
    /// Quality of the image (0-99)
    public var quality: Int? = nil {
        didSet {
            if let quality = self.quality {
                self.quality = max(0, min(99, quality))
            }
        }
    }
    
    /// Upscales the image
    public var upscale : Bool?
    
    /// Rotation of the image
    public var rotation: Rotation? = nil

    /// Background color of the image in hex format
    ///
    /// ````
    /// background = "ff0e3a"
    /// ````
    public var background: String? = nil
    
    /// Image border
    public var border: Border? = nil
    
    /// Alpha value of background color (0-100)
    public var alpha: Int = 100 {
        didSet {
            self.quality = max(0, min(100, alpha))
        }
    }
    
    /// Output format
    ///
    /// `nil` value returns image in original format
    public var outputFormat: OutputFormat?
    
    // MARK: Inits

    /// Initializes a new settings for image modifications. All parameters are optional
    ///
    /// - Parameters:
    ///   - width: Desired width of the image in pixels
    ///   - height: Desired height of the image in pixels
    ///   - size: Width and height of the image in pixels
    ///   - cropMode: CropMode
    ///   - gravity: Gravity of the image
    ///   - filters: Array of filters that should be applied to the image
    ///   - quality: Quality of the image (0-99)
    ///   - rotation: Rotation of image
    ///   - upscale: Upscale value of image
    ///   - background: Background color of the image in hex format without #
    ///   - alpha: Alpha value of background color (0-100)
    ///   - border: Image border
    ///   - outputFormat: Output format
    public init(size: ResizinSize? = nil, cropMode: CropMode? = nil, gravity: Gravity? = nil, filters: [Filter]? = nil, quality: Int? = nil, rotation: Rotation? = nil, upscale: Bool? = nil, background: String? = nil, alpha: Int = 100, border: Border? = nil, outputFormat: OutputFormat? = nil) {
        self.size = size
        self.cropMode = cropMode
        self.gravity = gravity
        self.filters = filters
        self.quality = quality
        self.rotation = rotation
        self.upscale = upscale
        self.background = background
        self.alpha = alpha
        self.border = border
        self.outputFormat = outputFormat
    }
    
    // MARK: Helpers
    
    /// Modifiers that will be applied on the image
    public var modifiers : [String] {
        var modifiers: [String] = []
        
        if let size = size {
            modifiers += size.modifiers
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
        if let outputFormat = outputFormat {
            modifiers.append("o_\(outputFormat)") }
        return modifiers
    }
}
