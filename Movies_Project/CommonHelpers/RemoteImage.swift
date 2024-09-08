//
//  RemoteImage.swift
//  Movies_Project
//
//  Created by Vishal  on 08/09/24.
//

import SwiftUI

struct CMPRemoteImage: View {
    @ObservedObject var imageLoader: ImageLoader

    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: imageLoader.contentMode)
        } else {
            ZStack {
                if let placeholder = imageLoader.placeholder {
                    placeholder
                        .resizable()
                        .aspectRatio(contentMode: imageLoader.contentMode)
                }
                ProgressView()
                    .controlSize(.regular)
            }
        }
    }
    
    func placeholder(_ image: Image?) -> CMPRemoteImage {
        self.imageLoader.placeholder = image
        return self
    }
    
    func contentMode(_ mode: ContentMode) -> CMPRemoteImage {
        self.imageLoader.contentMode = mode
        return self
    }
}

class ImageLoader: ObservableObject {
    @Published var placeholder: Image?
    @Published var image: UIImage?
    @Published var contentMode: ContentMode = .fit

    private var url: String
    private var task: URLSessionDataTask?

    init(url: String) {
        self.url = url
        loadImage()
    }

    private func loadImage() {
        if let cachedImage = ImageCache.shared.get(forKey: url) {
            self.image = cachedImage
            return
        }
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global(qos: .background).async {
            self.task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.image = image
                    ImageCache.shared.set(image, forKey: self.url)
                }
            }
            self.task?.resume()
        }
    }
}

final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private init() {}

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
