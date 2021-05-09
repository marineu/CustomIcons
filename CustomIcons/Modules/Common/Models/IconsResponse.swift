//
//  IconsResponse.swift
//  CustomIcons
//
//  Created by Marin Ipati on 09/05/2021.
//

import Foundation

struct IconsResponse: Decodable {
    
    var icons: Icons = []
    var errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case icons
    }
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
}
