//
//  WeatherDetailHeaderCollectionViewCell.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import UIKit

class WeatherDetailHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bagroundView: UIView!
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var detailLabel: UILabel?
    @IBOutlet var weatherImage: UIImageView?

    var detailModel: DetailModel? {
        didSet {
            guard let data = detailModel else {
                return
            }
            titleLabel?.text = data.title
            detailLabel?.text = data.description
            weatherImage?.image = UIImage(named: data.image!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
