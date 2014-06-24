//
//  ContainerViewController.swift
//  ExpandableBottomView
//
//  Created by Alex Corre on 6/23/14.
//  Copyright (c) 2014 Alex Corre. All rights reserved.
//

import UIKit

class ContainerViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var tableView : UITableView
  
  var items : String[] = [
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen",
    "twenty"
  ]
  
  // INITIALIZERS
  
  init() {
    super.init(nibName: "ContainerViewController", bundle: NSBundle.mainBundle())
  }
  
  // VIEW LIFECYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
  }
  
  // UITableViewDataSource
  
  func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
    var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
    cell.textLabel.text = self.items[indexPath.row]
    return cell
  }
  
  // UITableViewDelegate
  
  func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    println("You selected cell #\(indexPath.row)!")
  }

}
