//
//  OptimizedImageView.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 12/2/2025.
//

import SwiftUI
import UIKit

struct OptimizedImageView: View {
    let imageName: String
    @State private var uiImage: UIImage?

    var body: some View {
        Group {
            if let image = uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView() // Show loading indicator
            }
        }
        .onAppear {
            loadResizedImage(named: imageName, maxSize: 1024) { resizedImage in
                self.uiImage = resizedImage
            }
        }
    }

    func loadResizedImage(named name: String, maxSize: CGFloat, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let image = UIImage(named: name) else { return }
            
            let aspectRatio = image.size.width / image.size.height
            let newWidth = min(maxSize, image.size.width)
            let newHeight = newWidth / aspectRatio

            let renderer = UIGraphicsImageRenderer(size: CGSize(width: newWidth, height: newHeight))
            let resizedImage = renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: CGSize(width: newWidth, height: newHeight)))
            }

            DispatchQueue.main.async {
                completion(resizedImage)
            }
        }
    }
}

#Preview {
    OptimizedImageView(
        imageName: ""
    )
}
