//
//  IconsManager.swift
//  CustomIcons
//
//  Created by Marin Ipati on 09/05/2021.
//

import UIKit

class IconsManager: NSObject {
    
    public func loadIconsData(completion: ((IconsResponse) -> Void)? = nil) -> Void {
        let url = URL(string: Constants.iconsDataStringUrl)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                let errorMessage = error.localizedDescription
                let iconsResponse = IconsResponse(errorMessage: errorMessage)
                DispatchQueue.main.async { completion?(iconsResponse) }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let data = data
            else {
                let errorMessage = "Something went wrong"
                let iconsResponse = IconsResponse(errorMessage: errorMessage)
                DispatchQueue.main.async { completion?(iconsResponse) }
                return
            }
            
            do {
                let iconsResponse = try JSONDecoder()
                    .decode(IconsResponse.self, from: data)
                DispatchQueue.main.async { completion?(iconsResponse) }
            } catch {
                let errorMessage = error.localizedDescription
                let iconsResponse = IconsResponse(errorMessage: errorMessage)
                DispatchQueue.main.async { completion?(iconsResponse) }
            }
        }.resume()
    }

}
