//
//  UIViewControllerExtensions.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import UIKit

public enum Boards: String {
    case main = "Main"
}

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
    /// The storyboard identifier of viewcontroller
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    /// Initialize a viewcontroller
    /// - Parameter storyboard: storyboard enums
    /// - Returns: returns a viewcontroller
    static func initialize(_ storyboard: Boards) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self //swiftlint:disable:this force_cast
    }
}

protocol AlertPresentable {
    func showError(_ title: String, _ error: Error)
}

extension AlertPresentable where Self: UIViewController {
    /// Helper function to present error message
    /// - Parameters:
    ///   - title: title for the error
    ///   - error: error description
    func showError(_ title: String, _ error: Error) {
        let alertController = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    /// Helpers function to hide and show views
    /// - Parameters:
    ///   - views: array of views to hide or show
    ///   - hide: show or hide, true/false
    func hideShowViews(_ views: [UIView], hide: Bool) {
        views.forEach { $0.isHidden = hide }
    }
}

extension UIViewController: StoryboardInitializable, AlertPresentable {}
