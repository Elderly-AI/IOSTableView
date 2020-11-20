//
//  PhotoViewController.swift
//  tableView
//
//  Created by user on 15.11.2020.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var loadedImageView: UIImageView!
    
    var imageName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageName != nil {
            updateUI()
        }
    }
    
    func updateUI() {
        loadedImageView.image = UIImage(named: imageName)
    }
}
