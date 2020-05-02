//
//  DetailsFoodViewController.swift
//  Makan Cuy
//
//  Created by Christian Stevanus on 28/01/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import UIKit
import AlamofireImage
import MapKit
import CoreLocation

class DetailsFoodViewController: UIViewController {

    @IBOutlet weak var detailFoodView: DetailsFoodView?
    var viewModel: DetailViewModel? {
        didSet{
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailFoodView?.collectionView?.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        detailFoodView?.collectionView?.dataSource = self
        detailFoodView?.collectionView?.delegate = self
    }
    
    func updateView() {
        if let vm = viewModel {
            detailFoodView?.priceLabel?.text = vm.price
            detailFoodView?.hoursLabel?.text = vm.isOpen
            detailFoodView?.ratingsLabel?.text = vm.rating
            detailFoodView?.locationLabel?.text = vm.phoneNumber
            detailFoodView?.collectionView?.reloadData()
            centerMap(for: viewModel!.coordinate)
            title = viewModel?.name
        }
    }

    func centerMap(for coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        detailFoodView?.mapView?.addAnnotation(annotation)
        detailFoodView?.mapView?.setRegion(region, animated: true)
    }
}

extension DetailsFoodViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! DetailCollectionViewCell
        
        if let url = viewModel?.imageUrls[indexPath.item] {
            cell.imageView.af_setImage(withURL: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        detailFoodView?.pageControll?.currentPage = indexPath.item
    }
}
