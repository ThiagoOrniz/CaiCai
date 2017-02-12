//
//  CaiCaiView.swift
//  CaiCai
//
//  Created by Thiago Orniz Martin on 12/02/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class CaiCaiView: UIView, UIDynamicAnimatorDelegate
{
  
    private let dropBehavior = FallingObjectBehavior()
    
    private lazy var animator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self)
        animator.delegate = self
        return animator
    }()
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    var animating:Bool = false {
        didSet{
            if animating {
                animator.addBehavior(dropBehavior)
                animator.addBehavior(dropBehavior)
                
            } else {
                animator.removeBehavior(dropBehavior)
                animator.removeBehavior(dropBehavior)
            }
        }
    }
    
    private func removeCompletedRow(){
        
        var dropsToRemove = [UIView]()
        
        var hitTestRect = CGRect(origin: bounds.lowerLeft, size: dropSize)
        repeat {
            hitTestRect.origin.x = bounds.minX
            hitTestRect.origin.y -= dropSize.height
            
            var dropsTested = 0
            var dropsFound = [UIView]()
            
            while dropsTested < dropsPerRow {
                if let hitView = hitTest(p: hitTestRect.mid), hitView.superview == self {
                    dropsFound.append(hitView)
                } else {
                    break
                }
                hitTestRect.origin.x += dropSize.width
                dropsTested += 1
                
                if dropsTested == dropsPerRow {
                    dropsToRemove += dropsFound
                }
            }

        } while dropsToRemove.count == 0 && hitTestRect.origin.y > bounds.minY
    
        for drop in dropsToRemove {
            dropBehavior.removeItem(item: drop)
            drop.removeFromSuperview()
        }
    }
    
    private let dropsPerRow = 10
    
    private var dropSize:CGSize {
        
        let size = bounds.size.width/CGFloat(integerLiteral: dropsPerRow)
        return CGSize(width: size, height: size)
        
    }
    
    func addDrop(){
        var frame = CGRect(origin: CGPoint.zero, size: dropSize)
        frame.origin.x = CGFloat.random(max: dropsPerRow) * dropSize.width
        
        let drop = UIView(frame:frame)
        drop.backgroundColor = UIColor.random
        
        addSubview(drop)
        dropBehavior.addItem(item: drop)
        
        
    }
    
}
