//
//  ViewController.swift
//  Project1
//
//  Created by IBM-MOBILITY on 15/03/19.
//  Copyright © 2019 DurgaPrasad. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    fileprivate var pictures: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listImagesInProject()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func listImagesInProject() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let item = try? fm.contentsOfDirectory(atPath: path)
        guard let items = item else {
            print("There was not data in the app directory folder")
            fatalError("There is some issue with the app folder, It is not able to access it's own data")
        }
        for item in items {
//            print(items)
            if item.hasPrefix("nssl") {
                pictures.append(item)
                print(item)
            }
        }
        pictures.sort()
        print(pictures)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
        detailVC.selectedImage = pictures[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    }
}

