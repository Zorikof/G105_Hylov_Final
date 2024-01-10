
import UIKit

class ItemCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageVIew: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageVIew.layer.cornerRadius = 32
        cellImageVIew.layer.masksToBounds = true
    }
}
