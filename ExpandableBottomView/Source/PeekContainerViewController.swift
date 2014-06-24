//
//  PeekContainerViewController.swift
//  ExpandableBottomView
//
//  Created by Alex Corre on 6/23/14.
//  Copyright (c) 2014 Alex Corre. All rights reserved.
//

import UIKit

class PeekContainerViewController: UIViewController {
  
  @IBOutlet var mainView:UIView
  @IBOutlet var peekView:UIView
  @IBOutlet var dimmerView:UIView
  
  var isPeekAtTop = false
  var startingPeekTopPosition:CGFloat = 0.0
  
  let MAX_DIMMER_ALPHA = 0.7
  let PEEK_ANIMATION_DURATION = 0.17
  
  // INITIALIZERS
  
  init() {
    super.init(nibName: "PeekContainerViewController", bundle: NSBundle.mainBundle())
  }
  
  // VIEW LIFECYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // tap gesture recognizer to bottom view
    var tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "peekViewTapped:")
    peekView.addGestureRecognizer(tapGestureRecognizer)
    
    // pan gesture recognizer to bottom view
    var panGestureRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "peekViewMoved:")
    peekView.addGestureRecognizer(panGestureRecognizer)
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  // PEEK / DIMMER VIEW ANIMATIONS
  
  func peekViewTapped(recognizer:UIGestureRecognizer) {
    if isPeekAtTop {
      animatePeekToBottom()
    } else {
      animatePeekToTop()
    }
  }
  
  func animatePeekToTop() {
    UIView.animateWithDuration(PEEK_ANIMATION_DURATION,
      animations: {
        self.peekView.frame.origin.y = 20
        self.dimmerView.alpha = self.MAX_DIMMER_ALPHA
      },
      completion: {
        _ in
        self.isPeekAtTop = true
      })
  }
  
  func animatePeekToBottom() {
    UIView.animateWithDuration(PEEK_ANIMATION_DURATION,
      animations: {
        self.peekView.frame.origin.y = 498
        self.dimmerView.alpha = 0
      }, completion: {
        _ in
        self.isPeekAtTop = false
      })
  }
  
  func peekViewMoved(panRecognizer:UIPanGestureRecognizer) {
    if panRecognizer.state == UIGestureRecognizerState.Began {
      startingPeekTopPosition = peekView.frame.origin.y
    }
    
    if panRecognizer.state == UIGestureRecognizerState.Ended {
      var velocity = panRecognizer.velocityInView(peekView)
      
      if velocity.y == 0 {
        println("ENDED still")
        // TODO do something about this case...which somehow happens rarely
      } else if velocity.y > 0 {
        animatePeekToBottom()
      } else {
        animatePeekToTop()
      }
    
    } else {
      var translation = panRecognizer.translationInView(peekView)
      peekView.frame.origin.y = startingPeekTopPosition + translation.y
      adjustDimmerView(peekView.frame.origin.y)
    }
  }
  
  func adjustDimmerView(offset:CGFloat) {
    dimmerView.alpha = dimmerAlphaForOffset(offset)
  }
  
  func dimmerAlphaForOffset(offset:CGFloat) -> CGFloat {
    return (498.0 - offset) / (498.0 - 20.0) * MAX_DIMMER_ALPHA
  }

}
