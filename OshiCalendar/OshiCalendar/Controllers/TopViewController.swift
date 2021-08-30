//
//  ViewController.swift
//  OshiCalendar
//
//  Created by 平島峻成 on 2021/07/04.
//  Copyright © 2021 平島峻成. All rights reserved.
//

import UIKit
import CalculateCalendarLogic
import FSCalendar
import Views

//MARK:- vars and lifecycle
class TopViewController: UIViewController {
    private let gregorian: Calendar = Calendar(identifier: .gregorian)
    private lazy var myView = TopView()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    override func loadView() {
        view = myView
    }

}

//MARK:- UI
extension TopViewController{
    
    private func setUI(){
        self.setCalendar()
        self.setNavigationBar()
    }
    
    private func setCalendar(){
        myView.calendar.dataSource = self
        myView.calendar.delegate = self
    }
    
    private func setNavigationBar(){
        myView.navigationBar.delegate = self
        self.makeGradation()
    }
    
    private func setTable(){
        
    }

}

//MARK:- ナビゲーションバー設定
extension TopViewController:UINavigationBarDelegate{
    // ナビゲーションバーにグラデーションを追加
    private func makeGradation(){
        let image = UIImage(named: "BG")
        myView.navigationBar.setBackgroundImage(image, for: .default)
        myView.navigationBar.isTranslucent = true
    }
    
    // ナビゲーションバーを画面上部まで拡張
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

//MARK:- カレンダー設定
extension TopViewController:FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{

    // 祝日判定を行い結果を返すメソッド(True:祝日)
    private func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)

        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)

        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()

        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    private func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }

    //曜日判定(日曜日:1 〜 土曜日:7)
    private func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    //曜日の色と文字列を変更
    private func changeWeek(){
        myView.calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        myView.calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        myView.calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        myView.calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        myView.calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        myView.calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        myView.calendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        myView.calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor.red
        myView.calendar.calendarWeekdayView.weekdayLabels[1].textColor = UIColor.black
        myView.calendar.calendarWeekdayView.weekdayLabels[2].textColor = UIColor.black
        myView.calendar.calendarWeekdayView.weekdayLabels[3].textColor = UIColor.black
        myView.calendar.calendarWeekdayView.weekdayLabels[4].textColor = UIColor.black
        myView.calendar.calendarWeekdayView.weekdayLabels[5].textColor = UIColor.black
        myView.calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor.blue
    }

    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        changeWeek()
        
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            return UIColor.red
        }

        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }

        return nil
    }
}


//// MARK: - UITableViewDataSource
//extension ViewController:UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
//
//// MARK: - UITableViewDelegate
//extension ViewController:UITableViewDelegate{
//
//}

