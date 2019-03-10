// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Achievement: StoryboardType {
    internal static let storyboardName = "Achievement"

    internal static let achievementViewController = SceneType<AchievementViewController>(storyboard: Achievement.self, identifier: "AchievementViewController")
  }
  internal enum Download: StoryboardType {
    internal static let storyboardName = "Download"

    internal static let downloadViewController = SceneType<DownloadViewController>(storyboard: Download.self, identifier: "DownloadViewController")
  }
  internal enum Guide: StoryboardType {
    internal static let storyboardName = "Guide"

    internal static let guideViewController = SceneType<GuideViewController>(storyboard: Guide.self, identifier: "GuideViewController")
  }
  internal enum Init: StoryboardType {
    internal static let storyboardName = "Init"

    internal static let initViewController = SceneType<InitViewController>(storyboard: Init.self, identifier: "InitViewController")
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Mission: StoryboardType {
    internal static let storyboardName = "Mission"

    internal static let missionDetailViewController = SceneType<MissionDetailViewController>(storyboard: Mission.self, identifier: "MissionDetailViewController")

    internal static let missionViewController = SceneType<MissionViewController>(storyboard: Mission.self, identifier: "MissionViewController")
  }
  internal enum Performance: StoryboardType {
    internal static let storyboardName = "Performance"

    internal static let initialScene = InitialSceneType<UIKit.UINavigationController>(storyboard: Performance.self)

    internal static let performanceNavigationController = SceneType<UIKit.UINavigationController>(storyboard: Performance.self, identifier: "PerformanceNavigationController")

    internal static let performanceViewController = SceneType<PerformanceViewController>(storyboard: Performance.self, identifier: "PerformanceViewController")

    internal static let searchRecordDetailViewController = SceneType<SearchRecordDetailViewController>(storyboard: Performance.self, identifier: "SearchRecordDetailViewController")

    internal static let searchRecordViewController = SceneType<SearchRecordViewController>(storyboard: Performance.self, identifier: "SearchRecordViewController")

    internal static let skillLevelDetailViewController = SceneType<SkillLevelDetailViewController>(storyboard: Performance.self, identifier: "SkillLevelDetailViewController")

    internal static let summaryDetailViewController = SceneType<SummaryDetailViewController>(storyboard: Performance.self, identifier: "SummaryDetailViewController")
  }
  internal enum Ranking: StoryboardType {
    internal static let storyboardName = "Ranking"

    internal static let rankingViewController = SceneType<RankingViewController>(storyboard: Ranking.self, identifier: "RankingViewController")
  }
  internal enum Record: StoryboardType {
    internal static let storyboardName = "Record"

    internal static let recordViewController = SceneType<RecordViewController>(storyboard: Record.self, identifier: "RecordViewController")
  }
  internal enum SignIn: StoryboardType {
    internal static let storyboardName = "SignIn"

    internal static let signInViewController = SceneType<SignInViewController>(storyboard: SignIn.self, identifier: "SignInViewController")

    internal static let signNavigationController = SceneType<UIKit.UINavigationController>(storyboard: SignIn.self, identifier: "SignNavigationController")

    internal static let signUpViewController = SceneType<SignUpViewController>(storyboard: SignIn.self, identifier: "SignUpViewController")
  }
  internal enum Song: StoryboardType {
    internal static let storyboardName = "Song"

    internal static let songViewController = SceneType<SongViewController>(storyboard: Song.self, identifier: "SongViewController")
  }
  internal enum Tip: StoryboardType {
    internal static let storyboardName = "Tip"

    internal static let tipViewController = SceneType<TipViewController>(storyboard: Tip.self, identifier: "TipViewController")
  }
  internal enum Top50: StoryboardType {
    internal static let storyboardName = "Top50"

    internal static let top50ViewController = SceneType<Top50ViewController>(storyboard: Top50.self, identifier: "Top50ViewController")
  }
  internal enum Trophy: StoryboardType {
    internal static let storyboardName = "Trophy"

    internal static let trophyViewController = SceneType<TrophyViewController>(storyboard: Trophy.self, identifier: "TrophyViewController")
  }
  internal enum Upload: StoryboardType {
    internal static let storyboardName = "Upload"

    internal static let uploadViewController = SceneType<UploadViewController>(storyboard: Upload.self, identifier: "UploadViewController")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

private final class BundleToken {}
