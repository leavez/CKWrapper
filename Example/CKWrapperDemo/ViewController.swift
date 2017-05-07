//
//  ViewController.swift
//  CKWrapperDemo
//
//  Created by Gao on 22/04/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import UIKit
import CKWrapper

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ComponentProvider {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var datasource :CKWCollectionViewDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView);
        self.collectionView.frame = self.view.bounds
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.backgroundColor = .orange

        self.datasource = CKWCollectionViewDataSource(collectionView: collectionView, componentProvider: type(of:self), context: nil)
        self.collectionView.delegate = self
        self.collectionView.reloadData()

        print(UIScreen.main.bounds.size)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let changeset = ChangeSet<AnyObject>()
        changeset.insertedSections = [0]
        var insetItem: [IndexPath: NSObjectProtocol] = [:]
        for i in (0..<100) {
            insetItem[[0, i]] = NSObject()
        }
        changeset.insertedItems = insetItem

        self.datasource.apply(changeset: changeset, asynchronously: true)


//        let changeset2 = CKWChangeSet()
//        var insetItem2: [IndexPath: NSObjectProtocol] = [:]
//        for i in (0..<1) {
//            insetItem2[[0, i]] = NSObject()
//        }
//        changeset2.updatedItems  = insetItem2
//        self.datasource.applyChangeset(changeset2, asynchronized: false)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.datasource.sizeForItem(at: indexPath)
    }


    static func ckwComponent(forModel model: NSObjectProtocol, context: NSObjectProtocol?) -> Component? {

        return CompositeComponent(
            view:
            CKWViewConfiguration(
                attributeEnums:
                ViewAttributeEnum.backgroundColor(.white)
            ),
            component:
            SwiftComponent(model: 1)
        )
    }
}
