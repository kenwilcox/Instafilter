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
  var currentImage: UIImage!
  var context: CIContext!
  var currentFilter: CIFilter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    title = "Instafilter"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "importPicture")
    context = CIContext(options: nil)
    currentFilter = CIFilter(name: "CISepiaTone")
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
    applyProcessing()
  }
  
  func importPicture() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    presentViewController(picker, animated: true, completion: nil)
  }
  
  func applyProcessing() {
    currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
    
    let cgimg = context.createCGImage(currentFilter.outputImage!, fromRect: currentFilter.outputImage!.extent)
    let processedImage = UIImage(CGImage: cgimg)
    
    imageView.image = processedImage
  }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    var newImage: UIImage
    
    if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
      newImage = possibleImage
    } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      newImage = possibleImage
    } else {
      return
    }
    
    dismissViewControllerAnimated(true, completion: nil)
    
    currentImage = newImage
    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    
    applyProcessing()
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
