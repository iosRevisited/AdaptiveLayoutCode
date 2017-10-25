//
//  ViewController.swift
//  AdaptiveLayoutCode
//
//  Created by Sai Sandeep on 25/10/17.
//  Copyright © 2017 iosRevisited. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imgView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "kitten.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let sampleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "The Ragdoll is a cat breed with blue eyes and a distinct colourpoint coat. It is a large and muscular semi-longhair cat with a soft and silky coat. Like all long haired cats, Ragdolls need grooming to ensure their fur does not mat."
        label.textColor = UIColor.darkGray
        return label
    }()
    
    var defaultConstraints: [NSLayoutConstraint] = []
    
    var portraitConstraints: [NSLayoutConstraint] = []
    
    var landscapeConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.toggleConstraints), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        addUIElements()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func addUIElements() {
        let guide = view.safeAreaLayoutGuide
        
        // imgView Layouts
        view.addSubview(imgView)
        let defaultImgTop = imgView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0.0)
        let defaultImgLeading = imgView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0.0)
        
        // portrait
        let portraitImgTrailing = imgView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0.0)
        let portraitImgHeight = imgView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        
        // ImageView Landscape Constraints
        let landscapeImgBottom = imgView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0.0)
        let landscapeImgWidth = imgView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        
        // sampleLabel Layouts
        view.addSubview(sampleLabel)
        let defaultLblTrailing = sampleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10.0)
        let defaultLblBottom = sampleLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0.0)
        
        // portrait
        let portraitLblBottom = sampleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 0.0)
        let portraitLblLeading = sampleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10.0)
        
        // Label Landscape Constraints
        let landscapeLblTop = sampleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0.0)
        let landscapeLblTrailing = sampleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10.0)
        
        defaultConstraints = [defaultImgTop, defaultImgLeading, defaultLblBottom, defaultLblTrailing]
        portraitConstraints = [portraitImgHeight, portraitImgTrailing, portraitLblBottom, portraitLblLeading]
        landscapeConstraints = [landscapeImgWidth, landscapeImgBottom, landscapeLblTop, landscapeLblTrailing]
        
        view.addConstraints(defaultConstraints)
        self.toggleConstraints()
    }
    
    @objc func toggleConstraints() {
        if UIDevice.current.orientation.isLandscape {
            view.removeConstraints(portraitConstraints)
            view.addConstraints(landscapeConstraints)
        }else {
            view.removeConstraints(landscapeConstraints)
            view.addConstraints(portraitConstraints)
        }
    }
    
}


