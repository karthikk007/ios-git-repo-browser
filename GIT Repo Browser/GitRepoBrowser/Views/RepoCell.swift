//
//  RepoCell.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 06/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    
    static let identifier: String = "RepoCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        label.backgroundColor = UIColor.darkGray
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description: init(coder:) has not been implemented init(coder:) has not been implemented init(coder:) has not been implemented"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 2
//        label.backgroundColor = UIColor.darkGray
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Yeseterday"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
//                label.backgroundColor = UIColor.darkGray
        return label
    }()
    
    let chevronImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "chevron-right")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.contentMode = .scaleAspectFill
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return view
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: ReposModel) {
        nameLabel.text = data.name
        descriptionLabel.text = data.description
        
        
        timeLabel.text = HereDateFormatter.shared.getFormattedString(from: data.updatedAt!)
        
        configureBackground(isWiki: data.hasWiki ?? false)
    }
    
    private func configureBackground(isWiki: Bool) {
        
        switch isWiki {
        case true:
            backgroundColor = AppColors.cellBackgroundWiki.getColor().withAlphaComponent(0.9)
            nameLabel.textColor = AppColors.darkText.getColor()
            descriptionLabel.textColor = AppColors.darkText.getColor()
            timeLabel.textColor = AppColors.darkText.getColor()
        case false:
            backgroundColor = AppColors.cellBackgroundNonWiki.getColor().withAlphaComponent(0.9)
            nameLabel.textColor = AppColors.lightText.getColor()
            descriptionLabel.textColor = AppColors.lightText.getColor()
            timeLabel.textColor = AppColors.lightText.getColor()
        }
    }
    
    private func setupViews() {
        
        accessoryView = chevronImageView
        
        selectionStyle = .blue
        
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(timeLabel)
        
        nameLabel.frame = CGRect(x: 15, y: 10,
                                 width: UIScreen.main.bounds.width - 60, height: 20)
        descriptionLabel.frame = CGRect(x: 15, y: nameLabel.frame.origin.y + nameLabel.frame.height,
                                        width: UIScreen.main.bounds.width - 60, height: 40)
        timeLabel.frame = CGRect(x: 15, y: descriptionLabel.frame.origin.y + descriptionLabel.frame.height,
                                 width: UIScreen.main.bounds.width - 60, height: 20)
    }

}
