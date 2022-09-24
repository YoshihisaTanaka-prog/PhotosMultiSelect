//
//  ViewController.swift
//  PhotosMultiSelect
//
//  Created by 田中義久 on 2022/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    var items: [UIImage] = []
    @IBOutlet var photoCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setLayout()
    }

    func setLayout(){
        
        let cellSide = (UIScreen.main.bounds.size.width - 1.5) / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellSide, height: cellSide)
        flowLayout.minimumInteritemSpacing = 0.5
        flowLayout.minimumLineSpacing = 0.5
        flowLayout.sectionInset = UIEdgeInsets(top: 0.5, left: 0, bottom: 50, right: 0.5)
        
        photoCollectionView.collectionViewLayout = flowLayout
        photoCollectionView.register(MainViewCell.self, forCellWithReuseIdentifier: "Cell")
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
    }
    @IBAction func tapped(){
        self.performSegue(withIdentifier: "pictures", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "pictures":
            let nextNC = segue.destination as! UINavigationController
            let nextVC = nextNC.viewControllers[0] as! LibraryAlbumViewController
            nextVC.mainView = self
        default:
            break
        }
    }
}

extension ViewController: UICollectionViewDelegate{}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath as IndexPath) as! MainViewCell
        cell.setValue(thumbnail: items[indexPath.item])
        
        return cell
    }
}
