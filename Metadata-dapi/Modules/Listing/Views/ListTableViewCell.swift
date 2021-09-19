//
//  ListTableViewCell.swift
//  Metadata-dapi
//
//  Created by Nitanta Adhikari on 9/19/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        if let status = model.statusCode {
            subtitleLabel.text = status
            subtitleLabel.isHidden = false
        }
        if let size = model.size {
            subtitleLabel.text = size
            subtitleLabel.isHidden = false
        }
        if let imageURL = model.imageURL {
            logoImageView.isHidden = false
        }
    }
    
}
