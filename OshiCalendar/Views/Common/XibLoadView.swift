//
//  XibLoadView.swift
//  Views
//
//  Created by 平島峻成 on 2021/08/31.
//  Copyright © 2021 平島峻成. All rights reserved.
//

import UIKit

public class XibLoadView: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    private func loadNib() {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
