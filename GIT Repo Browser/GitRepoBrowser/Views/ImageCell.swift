//
//  ImageCell.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 12/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    static let identifier: String = "ImageCell"
    
    let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ios-application-placeholder")?.withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFit
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 2.0
                iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.color = UIColor.white
        ai.sizeThatFits(CGSize(width: 100, height: 100))
        return ai
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupFrames()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrames()
    }
    
    override func prepareForReuse() {
        profileImage.image = UIImage(named: "ios-application-placeholder")?.withRenderingMode(.alwaysTemplate)
        profileImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    // MARK: - view setup
    private func setupFrames() {
        profileImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: ItemAttributes) {
        activityIndicator.startAnimating()
        profileImage.loadImage(url: data.value, completion: { [weak self] () in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        })
    }
    
    private func setupViews() {
        
        selectionStyle = .none
        backgroundColor = AppColors.theme.getColor()
        
        addSubview(profileImage)
        addSubview(activityIndicator)
        
        setupFrames()
    }
}
