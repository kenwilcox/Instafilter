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
    let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .ActionSheet)
    ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .Default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .Default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIPixellate", style: .Default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CISepiaTone", style: .Default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .Default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .Default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIVignette", style: .Default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    presentViewController(ac, animated: true, completion: nil)
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
    let inputKeys = currentFilter.inputKeys
    
    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey) }
    if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }
    
    let cgimg = context.createCGImage(currentFilter.outputImage!, fromRect: currentFilter.outputImage!.extent)
    let processedImage = UIImage(CGImage: cgimg)
    
    self.imageView.image = processedImage
  }
  
  func setFilter(action: UIAlertAction!) {
    currentFilter = CIFilter(name: action.title!)
    
    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    
    applyProcessing()
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
