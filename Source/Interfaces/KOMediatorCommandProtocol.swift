//
//  KOMediatorCommandProtocol.swift
//  KOLocalizedString
//
//  Created by Oleksandr Khymych on 22.02.2018.
//

import Foundation
/// Mediator command protocol
protocol KOMediatorCommandProtocol {
    var language    : String                                { get }
    var isComplete  : Bool                                  { get }
    var lastUpdate  : [KOLocalizedObjectProtocol]           { get }
    var callback    : ((MediatorCommandState)->())?     { get set }
    var bundle      : Bundle?                               { get }
    func execute()
}
