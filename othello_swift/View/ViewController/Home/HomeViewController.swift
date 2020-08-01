//
//  HomeViewController.swift
//  othello_swift
//
//  Created by Kazuki on 2020/07/26.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

import UIKit
 
class HomeViewController: UIViewController, CustomDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.dataSource = self
        
        let customLayout = CustomLayout()
        customLayout.delegate = self
        collectionView.collectionViewLayout = customLayout
    }
 
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(38)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .black
        cell.frame.size.width = 38
        cell.frame.size.height = 38
        
        // 選択された箇所を青くする
        let selectedBGView = UIView(frame: cell.frame)
        selectedBGView.backgroundColor = .blue
        cell.selectedBackgroundView = selectedBGView

        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        // デフォルトではtrue
        return true
    }

    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        // デフォルトではtrue
        return true
    }

    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        print("Highlighted: \(indexPath)")
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        print("Unhighlighted: \(indexPath)")
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        print("Selected: \(indexPath)")
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        print("Deselected: \(indexPath)")
    }
}
