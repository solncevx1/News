//
//  Image.swift
//  TestProject
//
//  Created by Максим Солнцев on 8/31/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import Foundation
import Kingfisher


extension UIImageView {
    
    func setImage(urlImage: URL) {
        
        
        self.kf.setImage(with: urlImage)
        
    }
    
}
