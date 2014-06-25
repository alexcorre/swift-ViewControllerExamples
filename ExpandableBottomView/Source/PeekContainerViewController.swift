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
  var shouldAccountForStatusBar = true
  
  var draggingBeganPeekOffset:CGFloat?
  var collapsedPeekTopOffset:CGFloat
  var expandedPeekTopOffset:CGFloat = 0.0

  let SCREEN_RECT = UIScreen.mainScreen().bounds
  let MAX_DIMMER_ALPHA = 0.7
  let PEEK_ANIMATION_DURATION = 0.17
  let DEFAULT_BOTTOM_PEEK_HEIGHT = 70.0
  
  // INITIALIZERS
  
  init() {
    collapsedPeekTopOffset = SCREEN_RECT.height - DEFAULT_BOTTOM_PEEK_HEIGHT
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
    
    // Setup initial positions
    setupInitialPeekViewPosition()
    updatePeekViewOffsets()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  // PEEK / DIMMER VIEW ANIMATIONS
  
  func setupInitialPeekViewPosition() {
    peekView.frame.origin.y = collapsedPeekTopOffset
  }
  
  func updatePeekViewOffsets() {
    if shouldAccountForStatusBar {
      expandedPeekTopOffset = 20.0
    }
    
    // TODO update based on what bottom view controller wants
  }
  
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
        self.peekView.frame.origin.y = self.expandedPeekTopOffset
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
        self.peekView.frame.origin.y = self.collapsedPeekTopOffset
        self.dimmerView.alpha = 0
      }, completion: {
        _ in
        self.isPeekAtTop = false
      })
  }
  
  func peekViewMoved(panRecognizer:UIPanGestureRecognizer) {
    if panRecognizer.state == UIGestureRecognizerState.Began {
      draggingBeganPeekOffset = peekView.frame.origin.y
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
      peekView.frame.origin.y = draggingBeganPeekOffset! + translation.y
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
