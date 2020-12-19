//
//  SceneType.swift
//  Core
//
//  Created by Thatchaphon Sritrakul on 18/12/2563 BE.
//

import SwiftUI

public protocol SceneType {
    var storyboard: UIStoryboard { get }
    var identifier: String { get }
    func viewController() -> UIViewController
    func view() -> AnyView
}
