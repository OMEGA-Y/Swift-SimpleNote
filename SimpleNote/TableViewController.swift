//
//  TableViewController.swift
//  SimpleNote
//
//  Created by YunseonChoi on 2021/02/24.
//

import UIKit

class TableViewController: UITableViewController {
    
    var list:[TimeInterval] = [] // 빈 배열로 초기화, list의 타입은 TimeInterval 타입
    
    func makeNewDate() -> TimeInterval {
        let date = Date()
        return date.timeIntervalSince1970
    }
    
    @IBAction func doAddItem(_ sender: UIBarButtonItem) {
        let newtime = makeNewDate()
        list.append(newtime)
        if UserDataManager.shared.saveList(with: UserDataManager.LIST_KEY_DEFAULT, list: list) {
                    self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
                }
                //tableView.reloadData()
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
    
    func requestRemoveItem(at:Int) {
            let alert = UIAlertController(title: "삭제요청", message: "삭제하시겠습니까?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) {
                (action) in
                self.list.remove(at: at)
                //self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
                            if UserDataManager.shared.saveList(with: UserDataManager.LIST_KEY_DEFAULT, list: self.list) {
                                self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
                            }
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = UserDataManager.shared.getList(with: UserDataManager.LIST_KEY_DEFAULT)        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 // section이 없으면 아무 데이터도 표현할 수 없기 때문에 0 대신 1로 바꿈
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let str = timeString(time: list[indexPath.row])
        let txt = UserDataManager.shared.getMemo(with: str)
                
        var memoCell:UITableViewCell!
                
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier"){
            memoCell = cell
        }
        else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
            memoCell = cell
        }
                
        memoCell.textLabel?.text = str
        memoCell.detailTextLabel?.text = txt
                
        return memoCell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            let deleteAction = UITableViewRowAction (style: .destructive, title: "삭제") { (action, indexPath) in
                /*
                self.list.remove(at: indexPath.row);
                self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
                */
                self.requestRemoveItem(at: indexPath.row)
            }
            return [deleteAction]
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let timeStamp = list[indexPath.row]
                
                if let vc = self.storyboard?.instantiateViewController(identifier: "MemoVC") as? MemoVC {
                    vc.timestamp = timeStamp;
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                tableView.deselectRow(at: indexPath, animated:true)
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
