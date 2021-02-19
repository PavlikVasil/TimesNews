//
//  DetailViewController.swift
//  TimesNews
//
//  Created by Павел on 18.02.2021.
//

import UIKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndicator()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        updateUI()
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var multimediaImage: UIImageView!
    @IBOutlet weak var abstractLabel: UILabel!
    
    var item: StoreItem?
    
    
    func updateUI(){
        let imageURLString = item?.multimedia[0].url ?? ""
        let imageURL = URL(string: imageURLString )
        multimediaImage.kf.setImage(with: imageURL)
        abstractLabel.text = item?.abstract
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        activityIndicator.hidesWhenStopped = true
    }
    
    func setupIndicator(){
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
    }
}
