
import UIKit

class ImageTableViewCell: UITableViewCell {
  
    @IBOutlet weak var loadedImageView: UIImageView!
    
    var imageName: String! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        loadedImageView.image = UIImage(named: imageName)
        loadedImageView.layer.cornerRadius = 5.0
        loadedImageView.layer.masksToBounds = true
    }
}
