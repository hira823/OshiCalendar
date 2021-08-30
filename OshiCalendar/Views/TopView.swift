//
//  ViewController.swift
//  OshiCalendar
//
//  Created by 平島峻成 on 2021/07/04.
//  Copyright © 2021 平島峻成. All rights reserved.
//

import UIKit
import FSCalendar

public final class TopView: XibLoadView {
    @IBOutlet public weak var navigationBar: UINavigationBar!
    @IBOutlet public weak var calendar: FSCalendar!
}

