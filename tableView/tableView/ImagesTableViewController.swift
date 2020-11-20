//
//  ImagesTableViewController.swift
//  tableView
//
//  Created by user on 14.11.2020.
//

import UIKit

class ImagesTableViewController: UITableViewController {
    
    //"8cebe4fdb0ce2ce1565312fa4e281596", "700ba", "vhod"
    var images:[String] = []
    var fetchingMore:Bool = false
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return images.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let photoViewController = mainStoryboard.instantiateViewController(identifier: "PhotoViewController") as! PhotoViewController
        photoViewController.imageName = images[indexPath.row]
        navigationController?.pushViewController(photoViewController, animated: true)
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
            cell.imageName = images[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadCell", for: indexPath) as! LoadTableViewCell
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let image = UIImage(named: images[indexPath.row])
            let imageRatio = image!.getImageRatio()
            let cellHeight = imageRatio * tableView.frame.width
            return cellHeight
        }
        return 40.0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        fetchingMore = true
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.images.append(contentsOf: ["8cebe4fdb0ce2ce1565312fa4e281596", "700ba", "vhod", "8cebe4fdb0ce2ce1565312fa4e281596", "700ba", "vhod"])
            self.fetchingMore = false
            self.tableView.reloadData()
        })
    }
}
