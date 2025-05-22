//
//  SwiftPopupPresentationController.swift
//  SwiftPopup
//
//  Created by CatchZeng on 2018/1/8.
//

import Foundation

open class SwiftPopupPresentationController: UIPresentationController {
    
    public var backViewColor = UIColor(white: 0.1, alpha: 0.5) {
        didSet {
            backgroundView.backgroundColor = backViewColor
        }
    }
    
    private lazy var backgroundView = UIView(frame: CGRect.zero)
    
    // MARK: Override Methods
    
    override open func presentationTransitionWillBegin() {
        guard let containerView else {
            return
        }
        
        containerView.insertSubview(backgroundView, at: 0)
        
        // Disable autoresizing mask translation
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints using NSLayoutConstraint
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        excuteBackgroundAnimation()
    }
    
    override open func dismissalTransitionWillBegin() {
        excuteBackgroundDismissAnimation()
    }
    
    override open var shouldRemovePresentersView: Bool {
        return false
    }
    
    // MARK: Private Methods
    
    fileprivate func excuteBackgroundAnimation() {
        backgroundView.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (_) in
                self.backgroundView.alpha = 1
            }, completion: nil)
        }
    }
    
    fileprivate func excuteBackgroundDismissAnimation() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
}
