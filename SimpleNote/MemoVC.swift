//
//  MemoVC.swift
//  SimpleNote
//
//  Created by YunseonChoi on 2021/02/24.
//

import UIKit

class MemoVC: UIViewController {

    @IBAction func doSaveMemo(_ sender: Any) {
        let str = timeString(time: timestamp)
        if UserDataManager.shared.saveMemo(with: str, memo: tvMemoInput.text) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() { // 화면이 켜질 때 메모를 불러오는 코드
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setMemoText()
    }
    
    private func setMemoText() {
        let str = timeString(time: timestamp)
        self.title = str
        let txt = UserDataManager.shared.getMemo(with: str)
        self.tvMemoInput.text = txt
    }
        
    func timeString(time:TimeInterval)->String {
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss.SSSS" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
        }
    
    
    @IBOutlet weak var tvMemoInput: UITextView!
    var timestamp:TimeInterval!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
