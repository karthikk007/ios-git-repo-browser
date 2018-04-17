//
//  UIImageView+Extension.swift
//  Git Repo Browser
//
//  Created by Karthik Kumar on 12/04/18.
//  Copyright © 2018 Karthik Kumar. All rights reserved.
//

import UIKit

// MARK: - UIImageView perform load image
extension UIImageView {
    func loadImage(url: String, completion: @escaping () -> ()) {
        
        guard let url = URL(string: url) else {
            updateErrorImage(completion: completion)
            completion()
            return
        }
        
        DownloadManager.shared.loadImage(url: url, completion: { [weak self] (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self?.contentMode = .scaleAspectFill
                    self?.image = image
                    completion()
                }
            } else {
                self?.updateErrorImage(completion: completion)
                completion()
            }
        })
    }
    
    private func updateErrorImage(completion: @escaping () -> ()) {
        let errorImage = UIImage(named: "error")?.withRenderingMode(.alwaysTemplate)
        DispatchQueue.main.async {
            self.image = errorImage
            self.tintColor = UIColor.red
            completion()
        }
    }
}
