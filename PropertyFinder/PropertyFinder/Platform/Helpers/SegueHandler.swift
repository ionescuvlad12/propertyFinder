//
//  SegueHandler.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//
import UIKit


enum SegueHandlerError: Error {
    case invalidSegue(String?)
}


protocol SegueHandler {
    associatedtype SegueIdentifier: RawRepresentable
}

protocol UnwindSegueHandler {
    associatedtype UnwindSegueIdentifier: RawRepresentable
}


extension SegueHandler where Self: UIViewController,
SegueIdentifier.RawValue == String {
    
    func performSegue(withIdentifier segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifier(for segue: UIStoryboardSegue) throws -> SegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
            else { throw SegueHandlerError.invalidSegue(segue.identifier) }
        return segueIdentifier
    }
}


extension UnwindSegueHandler where Self: UIViewController,
UnwindSegueIdentifier.RawValue == String {
    
    func performSegue(withIdentifier segueIdentifier: UnwindSegueIdentifier, sender: AnyObject?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    func unwindSegueIdentifier(for segue: UIStoryboardSegue) throws -> UnwindSegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier = UnwindSegueIdentifier(rawValue: identifier)
            else { throw SegueHandlerError.invalidSegue(segue.identifier) }
        return segueIdentifier
    }
}
