//
//  CollectionViewCell.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/02.
//  Copyright © 2020 susu. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var selectedFrameView: RectangleView!
    @IBOutlet weak var highlightView: UIView!

    // 選択状態の表示にselectedBackgroundViewを使うか自前Viewを使うかを切り替えられる
    let useSelectedBackgroundView = false

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedFrameView.isHidden = false
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override var isSelected: Bool {
        didSet {
            if !self.useSelectedBackgroundView {
                // セルの選択状態変化に応じて表示を切り替える
                self.highlightView.alpha = self.isSelected ? 1.0 : 0.0
                self.highlightView.backgroundColor = self.isSelected ? .black : .white
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if !self.useSelectedBackgroundView {
                // セルの押している最中だけ表示を切り替える
                UIView.animate(withDuration: 0.1) {
                    self.highlightView.alpha = self.isHighlighted ? 0.3 : 0.0
                }
            }
        }
    }
}
