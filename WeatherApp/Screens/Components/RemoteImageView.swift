//
//  RemoteImageView.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import SwiftUI

@available(iOS 13, *)
struct RemoteImageView: View {
    
    @ObservedObject var remoteImageURL: RemoteImageURL
    
    init(imageURL: String) {
        self.remoteImageURL = RemoteImageURL(imageURL: imageURL)
    }
    
    var body: some View {
        let data = remoteImageURL.data
        if !data.isEmpty, let image = UIImage(data: remoteImageURL.data) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            defaultImage
        }
    }
    
    var defaultImage: some View {
        Image("missing_weather")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

/// We need to conform the object to equatable in order to avoid unnecessary reloads in
/// the views when the view model changes but nothing changes for this specific item
@available(iOS 13, *)
extension RemoteImageView: Equatable {
    static func == (lhs: RemoteImageView, rhs: RemoteImageView) -> Bool {
        lhs.remoteImageURL == rhs.remoteImageURL
    }
}

@available(iOS 13, *)
class RemoteImageURL: ObservableObject {
    
    @Published var data = Data()
    let imageURL: String
    
    init(imageURL: String) {
        self.imageURL = imageURL
        guard let url = URL(string: imageURL) else { return }

        // Check for cached image
        if let image = ImageCache.shared.get(forKey: imageURL)?.pngData() {
            DispatchQueue.main.async {
                self.data = image
            }
            return
        }

        // Perform request for Image
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            // Store image in cache
            if let image = UIImage(data: data) {
                ImageCache.shared.set(forKey: imageURL, image: image)
            }
            // Return image
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}

/// We need to conform the object to equatable in order to avoid unnecessary reloads in
/// the views when the view model changes but nothing changes for this specific item
@available(iOS 13, *)
extension RemoteImageURL: Equatable {
    static func == (lhs: RemoteImageURL, rhs: RemoteImageURL) -> Bool {
        lhs.imageURL == rhs.imageURL
    }
}

// MARK: - Image Cache Implementation

@available(iOS 13, *)
class ImageCache {
    static let shared = ImageCache()
    var cache = NSCache<NSString, UIImage>()

    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }

    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}
