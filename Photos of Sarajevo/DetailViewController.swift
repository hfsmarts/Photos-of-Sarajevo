//
//  DetailViewController.swift
//  Photos of Sarajevo
//
//  Created by Harun Fazlic on 2. 3. 2022..
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var ImageView: UIImageView!
    var selectedImage: String?
    var titleWithout: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleWithout
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    
        
        if let imageToLoad = selectedImage{
            ImageView.image = UIImage(named: imageToLoad)
        }
        

        
   NotificationCenter.default.addObserver(self, selector: #selector(userTookScreenShoot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }
    
    
    @objc func shareTapped(){
        
        guard let image = ImageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        guard let titleFor = title else{
            print("no title found")
            return
        }
                
        let vc = UIActivityViewController(activityItems: [image, titleFor], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
       
    }
    
 
    
    
    
    
    
    @objc func userTookScreenShoot(){
        let alert = UIAlertController(title: "Screenshoot", message: "You took a screenshoot", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
            }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
