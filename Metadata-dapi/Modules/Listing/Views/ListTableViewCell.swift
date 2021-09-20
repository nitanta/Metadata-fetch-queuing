//
//  ListTableViewCell.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        [logoImageView, subtitleLabel].forEach { $0?.isHidden = true }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [logoImageView, subtitleLabel].forEach { $0?.isHidden = true }
    }
    
    /// Populate the cell
    /// - Parameter model: Listing model of the pokemon
    func configure(model: ListingModel) {
        self.titleLabel.text = model.url
        switch model.state {
        case .successful(let iconURL, let dataSize):
            [logoImageView, subtitleLabel].forEach { $0?.isHidden = false }
            logoImageView.kf.setImage(with: URL(string: iconURL))
            subtitleLabel.text = dataSize
        case .failed(let error):
            subtitleLabel.text = "\(error)"
            [subtitleLabel].forEach { $0?.isHidden = false }
        default:
            break
        }
    }
    
}
