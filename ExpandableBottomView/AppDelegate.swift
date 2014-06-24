//
//  AppDelegate.swift
//  ExpandableBottomView
//
//  Created by Alex Corre on 6/23/14.
//  Copyright (c) 2014 Alex Corre. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    var tableViewController:DemoTableViewController = DemoTableViewController()
    var peekContainerVC:PeekContainerViewController = PeekContainerViewController()
//    var peekContainerVC:PeekContainerViewController = PeekContainerViewController(mainVC: tableViewController)
    
    self.window!.rootViewController = peekContainerVC
    
    self.window!.backgroundColor = UIColor.whiteColor()
    self.window!.makeKeyAndVisible()
    return true
  }

}

