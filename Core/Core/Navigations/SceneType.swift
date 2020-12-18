//
//  SceneType.swift
//  Core
//
//  Created by Thatchaphon Sritrakul on 18/12/2563 BE.
//

import UIKit

public protocol SceneType {
    func viewController() -> UIViewController
    var storyboard: UIStoryboard { get }
    var identifier: String { get }
}
