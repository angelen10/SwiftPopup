//
//  SwiftPopupAnimation.swift
//  SwiftPopup
//
//  Created by CatchZeng on 2018/1/8.
//

import UIKit

open class SwiftPopupShowAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var duration: TimeInterval = 0.4
    public var delay: TimeInterval = 0.0
    public var springWithDamping: CGFloat = 0.7
    public var springVelocity: CGFloat = 0.7
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        toView.frame = transitionContext.finalFrame(for: toViewController)
        containerView.addSubview(toView)
        
        // 初始状态（添加透明度变化会更平滑）
        toView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        toView.alpha = 0
        
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: springWithDamping,
            initialSpringVelocity: springVelocity,
            options: [.curveEaseInOut, .allowUserInteraction],
            animations: {
                toView.transform = .identity
                toView.alpha = 1
            },
            completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}

open class SwiftPopupDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var duration: TimeInterval = 0.25
    public var delay: TimeInterval = 0.0
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view( forKey: UITransitionContextViewKey.from)
            else {
                return
        }
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseInOut,
                       animations: {
                        fromView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                        fromView.alpha = 0.0
        }) { (finished) in
            fromView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            fromView.alpha = 1.0
            transitionContext.completeTransition(finished)
        }
    }
}
