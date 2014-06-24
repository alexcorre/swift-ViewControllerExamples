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
    
    var vc:DemoTableViewController = DemoTableViewController()
    self.window!.rootViewController = vc
    
    self.window!.backgroundColor = UIColor.whiteColor()
    self.window!.makeKeyAndVisible()
    return true
  }

}

