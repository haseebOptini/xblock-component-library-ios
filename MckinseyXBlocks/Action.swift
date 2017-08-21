//
//  Action.swift
//  MckinseyXBlocks
//
//  Created by Salman Jamil on 8/21/17.
//  Copyright © 2017 Salman Jamil. All rights reserved.
//

import Foundation

public protocol XBlock {
    var action: Action? { get }
}

public protocol Action {
    var title: String { get }
    func execute()
}

public enum ActionState {
    case enabled
    case disabled
}

public protocol ActionStateListener {
    var state: ActionState { get }
}

extension XBlock {
    var action: Action? {
        return nil
    }
}
