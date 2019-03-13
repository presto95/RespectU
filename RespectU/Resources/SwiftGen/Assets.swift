// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let achievement = ImageAsset(name: "achievement")
  internal static let backButton = ImageAsset(name: "backButton")
  internal static let bpmDefault = ImageAsset(name: "bpmDefault")
  internal static let cancelButton = ImageAsset(name: "cancelButton")
  internal static let black50 = ColorAsset(name: "black50")
  internal static let main = ColorAsset(name: "main")
  internal static let absoluteSound = ColorAsset(name: "absoluteSound")
  internal static let stylishPerformance = ColorAsset(name: "stylishPerformance")
  internal static let electronicCity = ColorAsset(name: "electronicCity")
  internal static let metropolis = ColorAsset(name: "metropolis")
  internal static let blackDisk = ColorAsset(name: "blackDisk")
  internal static let whiteDisk = ColorAsset(name: "whiteDisk")
  internal static let anotherWorld = ColorAsset(name: "anotherWorld")
  internal static let backStage = ColorAsset(name: "backStage")
  internal static let chaosTheory = ColorAsset(name: "chaosTheory")
  internal static let clubRoad645 = ColorAsset(name: "clubRoad645")
  internal static let departure = ColorAsset(name: "departure")
  internal static let destination = ColorAsset(name: "destination")
  internal static let developers = ColorAsset(name: "developers")
  internal static let maxTheater = ColorAsset(name: "maxTheater")
  internal static let soundLab = ColorAsset(name: "soundLab")
  internal static let visualizer = ColorAsset(name: "visualizer")
  internal static let platinumMixing = ColorAsset(name: "platinumMixing")
  internal static let technicalMixing = ColorAsset(name: "technicalMixing")
  internal static let clubMixing = ColorAsset(name: "clubMixing")
  internal static let starMixing = ColorAsset(name: "starMixing")
  internal static let crewChallenge = ColorAsset(name: "crewChallenge")
  internal static let popMixing = ColorAsset(name: "popMixing")
  internal static let rSide = ColorAsset(name: "rSide")
  internal static let tSide = ColorAsset(name: "tSide")
  internal static let bs = ColorAsset(name: "bs")
  internal static let ce = ColorAsset(name: "ce")
  internal static let portable1 = ColorAsset(name: "portable1")
  internal static let portable2 = ColorAsset(name: "portable2")
  internal static let respect = ColorAsset(name: "respect")
  internal static let technika1 = ColorAsset(name: "technika1")
  internal static let technika2 = ColorAsset(name: "technika2")
  internal static let technika3 = ColorAsset(name: "technika3")
  internal static let trilogy = ColorAsset(name: "trilogy")
  internal static let sub = ColorAsset(name: "sub")
  internal static let bronze = ColorAsset(name: "bronze")
  internal static let gold = ColorAsset(name: "gold")
  internal static let platinum = ColorAsset(name: "platinum")
  internal static let silver = ColorAsset(name: "silver")
  internal static let credit = ImageAsset(name: "credit")
  internal static let download = ImageAsset(name: "download")
  internal static let email = ImageAsset(name: "email")
  internal static let fail = ImageAsset(name: "fail")
  internal static let favorite = ImageAsset(name: "favorite")
  internal static let info = ImageAsset(name: "info")
  internal static let log = ImageAsset(name: "log")
  internal static let manual = ImageAsset(name: "manual")
  internal static let mission = ImageAsset(name: "mission")
  internal static let more = ImageAsset(name: "more")
  internal static let nextButton = ImageAsset(name: "nextButton")
  internal static let question = ImageAsset(name: "question")
  internal static let radio = ImageAsset(name: "radio")
  internal static let random = ImageAsset(name: "random")
  internal static let rate = ImageAsset(name: "rate")
  internal static let respectuColor = ImageAsset(name: "respectuColor")
  internal static let search = ImageAsset(name: "search")
  internal static let shareButton = ImageAsset(name: "shareButton")
  internal static let song = ImageAsset(name: "song")
  internal static let sort = ImageAsset(name: "sort")
  internal static let success = ImageAsset(name: "success")
  internal static let tip = ImageAsset(name: "tip")
  internal static let trophyBronze = ImageAsset(name: "trophy_bronze")
  internal static let trophyGold = ImageAsset(name: "trophy_gold")
  internal static let trophyPlatinum = ImageAsset(name: "trophy_platinum")
  internal static let trophySilver = ImageAsset(name: "trophy_silver")
  internal static let trophy = ImageAsset(name: "trophy")
  internal static let upload = ImageAsset(name: "upload")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
