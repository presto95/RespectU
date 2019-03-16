//
//  CellColorizable.swift
//  RespectU
//
//  Created by Presto on 16/03/2019.
//  Copyright © 2019 Presto. All rights reserved.
//

import Foundation
import UIKit

/// The `protocol` that defines the colorizable behavior.
protocol CellColorizable: class {
  
  /// The labels that effected by the methods that the protocol requires.
  var labels: [UILabel] { get }
  
  /// Colorizes subviews.
  ///
  /// - Parameter series: The specific series.
  func colorizeSubviews(in series: Series)
  
  /// Decolorizes subviews.
  ///
  /// Reset all the colors of subviews.
  func decolorizeSubviews()
}

// MARK: - CellColorizable protocol extension

extension CellColorizable where Self: UITableViewCell {
  
  func colorizeSubviews(in series: Series) {
    DispatchQueue.main.async { [weak self] in
      switch series {
      case .portable1:
        self?.contentView.backgroundColor = .portable1
        self?.labels.forEach { $0.textColor = .white }
      case .portable2:
        self?.contentView.backgroundColor = .portable2
        self?.labels.forEach { $0.textColor = .white }
      case .respect:
        self?.contentView.backgroundColor = .respect
        self?.labels.forEach { $0.textColor = .white }
      case .trilogy:
        self?.contentView.backgroundColor = .trilogy
        self?.labels.forEach { $0.textColor = .white }
      case .ce:
        self?.contentView.backgroundColor = .ce
        self?.labels.forEach { $0.textColor = .black50 }
      case .technika1:
        self?.contentView.backgroundColor = .technika1
        self?.labels.forEach { $0.textColor = .white }
      case .bs:
        self?.contentView.backgroundColor = .bs
        self?.labels.forEach { $0.textColor = .white }
      case .technika2:
        self?.contentView.backgroundColor = .technika2
        self?.labels.forEach { $0.textColor = .white }
      case .technika3:
        self?.contentView.backgroundColor = .technika3
        self?.labels.forEach { $0.textColor = .white }
      default:
        break
      }
    }
  }
  
  func decolorizeSubviews() {
    DispatchQueue.main.async { [weak self] in
      self?.contentView.backgroundColor = .white
      self?.labels.forEach { $0.textColor = .black50 }
    }
  }
}
