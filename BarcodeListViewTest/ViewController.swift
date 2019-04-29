//
//  ViewController.swift
//  BarcodeListViewTest
//
//  Created by Henk van der Spek on 29/04/2019.
//  Copyright © 2019 Henk van der Spek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = .init()
        }
    }
    
    private let barcodeLists: [BarcodeList] = {
        return [
            .init(
                items: [
                    .init(
                        type: .qr,
                        value: "",
                        title: "8787887987992",
                        description: "Line 1\nLine 2\nLine 3\nLine 4"
                    ),
                    .init(
                        type: .pdf,
                        value: "",
                        title: "1234567890123",
                        description: "Line 1\nLine 2\nLine 3\nLine 4\nLine 5"
                    )
                ]
            )
        ]
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barcodeLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return BarcodeListTableViewCell(barcodeList: barcodeLists[indexPath.item])
    }
}
