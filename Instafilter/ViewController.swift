//
//  ViewController.swift
//  Instafilter
//
//  Created by Kenneth Wilcox on 1/4/16.
//  Copyright © 2016 Kenneth Wilcox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var intensity: UISlider!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func changeFilter(sender: AnyObject) {
    
  }
  
  @IBAction func save(sender: AnyObject) {
    
  }
  
  @IBAction func intensityChanged(sender: AnyObject) {
    
  }
}

