//
//  BarcodeListTableViewCell.swift
//  BarcodeListViewTest
//
//  Created by Henk van der Spek on 29/04/2019.
//  Copyright © 2019 Henk van der Spek. All rights reserved.
//

import UIKit

enum BarcodeType {
    case pdf
    case qr
}

struct BarcodeList {
    struct Item {
        let type: BarcodeType
        let value: String
        let title: String
        let description: String
    }
    let items: [Item]
}

class BarcodeListTableViewCell: UITableViewCell {
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.leadingAnchor.constraint(equalTo: leftButton.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: rightButton.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: leftButton.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor).isActive = true
        view.topAnchor.constraint(equalTo: rightButton.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: rightButton.bottomAnchor).isActive = true
        return view
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        return button
    }()
    
    private lazy var collectionView: BarcodeItemCollectionView = {
        let view = BarcodeItemCollectionView(barcodeList: barcodeList)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let barcodeList: BarcodeList
    
    init(barcodeList: BarcodeList) {
        self.barcodeList = barcodeList
        super.init(style: .default, reuseIdentifier: nil)
        selectionStyle = .none
        contentView.addSubview(headerView)
        contentView.addSubview(collectionView)
        headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class BarcodeItemCollectionView: UICollectionView {
    
    private let barcodeList: BarcodeList
    private let layout: Layout
    
    private class Layout: UICollectionViewFlowLayout {
        private let barcodeList: BarcodeList
        init(barcodeList: BarcodeList) {
            self.barcodeList = barcodeList
            super.init()
            applyItemSize()
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func prepare() {
            applyItemSize()
            scrollDirection = .horizontal
            sectionInset = .zero
            minimumInteritemSpacing = 0.0
        }
        private func applyItemSize() {
            let width = collectionView?.bounds.size.width ?? CGFloat(0.0)
            let heights = barcodeList.items.map { BarcodeItemCollectionViewCell(barcodeItem: $0).systemLayoutSizeFitting(.zero).height }
            let height = heights.max() ?? 0.0
            itemSize = .init(width: width, height: height)
        }
    }
    
    init(barcodeList: BarcodeList) {
        self.barcodeList = barcodeList
        self.layout = Layout(barcodeList: barcodeList)
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .white
        dataSource = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInset = .zero
        register(BarcodeItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: UIView.noIntrinsicMetric, height: layout.itemSize.height)
    }
}

extension BarcodeItemCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return barcodeList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BarcodeItemCollectionViewCell
        cell.barcodeItem = barcodeList.items[indexPath.item]
        return cell
    }
}

private class BarcodeItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, titlelabel, descriptionLabel])
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.alignment = .top
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    var barcodeItem: BarcodeList.Item? {
        didSet {
            titlelabel.text = barcodeItem?.title
            descriptionLabel.text = barcodeItem?.description
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    convenience init(barcodeItem: BarcodeList.Item) {
        self.init(frame: .zero)
        titlelabel.text = barcodeItem.title
        descriptionLabel.text = barcodeItem.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return stackView.systemLayoutSizeFitting(targetSize)
    }
}
