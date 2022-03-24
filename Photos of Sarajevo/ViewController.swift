//  ViewController.swift
//  Photos of Sarajevo
//  Created by Harun Fazlic on 2. 3. 2022..

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var pictureNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sarajevo Photos"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items{
            if item.hasPrefix("Sa"){
                pictures.append(item)
                pictures.sort()
            }
        }
        
        for picture in pictures{
            pictureNames.append(picture.description.replacingOccurrences(of: ".jpg", with: "", options: NSString.CompareOptions.literal, range: nil))
        }
        
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictureNames[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.titleWithout = pictureNames[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
}

