//
//  RestaurantTableViewCell.swift
//  The Fork
//
//  Created by Charbel Mattar on 08/03/2022.
//

import UIKit
import SDWebImage

class RestaurantTableViewCell: UITableViewCell {

    var data: RestaurantModel = RestaurantModel()
    let sourceImage = UIImageView()
    let nameLabel = UILabel()
    let addressLabel = UILabel()
    let ratingLabel = UILabel()
    let favButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true
        
        sourceImage.backgroundColor = .lightGray
        sourceImage.contentMode = .scaleAspectFill
        contentView.addSubview(sourceImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(favButton)
        
        favButton.addTarget(self, action: #selector(didTapFavButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = contentView.frame;
        frame.origin.x = 10
        frame.size.width = self.contentView.frame.width-20.0
        contentView.frame = frame
        
        frame.origin.x = 0
        frame.origin.y = 0
        frame.size.width = frame.size.width
        frame.size.height = frame.size.width*344/612
        sourceImage.frame = frame
        
        frame.origin.x = 10
        frame.size.width -= 20
        frame.origin.y += frame.size.height+10
        frame.size.height = 30
        nameLabel.frame = frame
        
        frame.origin.y += frame.size.height+10
        frame.size.height = 30
        addressLabel.frame = frame
        
        frame.origin.y += frame.size.height+10
        frame.size.height = 30
        ratingLabel.frame = frame
        
        frame.origin.x = self.contentView.frame.width-40
        frame.size.height = 30
        frame.size.width = 30
        favButton.frame = frame
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(dataModel: RestaurantModel) {
        self.data = dataModel
        self.sourceImage.sd_setImage(with: URL(string: dataModel.image))
        self.nameLabel.text = dataModel.name
        self.addressLabel.text = dataModel.address
        if let rating = Double(dataModel.rating){
            self.ratingLabel.text = "Rating: \(floor(rating * 10) / 10.0)"
        }
        self.setFavButtonImage()
    }
    
    @objc func didTapFavButton(){
        RestaurantsDataModel.shared.setFavorite(uuid: self.data.uuid, isFav: (self.data.isFav == "1" ? "0" : "1"))
        self.setFavButtonImage()
    }

    func setFavButtonImage(){
        if(self.data.isFav == "1"){
            self.favButton.setImage(UIImage(named: "filled-heart"), for: .normal)
        }else{
            self.favButton.setImage(UIImage(named: "empty-heart"), for: .normal)
        }
    }
    
}
