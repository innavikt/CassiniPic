//
//  ImageViewController.swift
//  Cassini
//
//  Created by inna on 19/04/2019.
//  Copyright © 2019 inna. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        } set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            DispatchQueue.global(qos: .userInitiated).async {
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.stanford
        }
    }
    
    
    
    
}
