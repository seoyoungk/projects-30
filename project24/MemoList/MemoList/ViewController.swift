//
//  ViewController.swift
//  MemoList
//
//  Created by Seoyoung on 01/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func add(_ sender: Any) {
        let action = UIAlertController(title: "목록 입력", message: "메모할 내용을 입력하세요", preferredStyle: .alert)
        action.addTextField { (tf) in
            tf.placeholder = "내용을 입력하세요"
        }
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            if let title = action.textFields?[0].text {
                self.list.append(title)
                self.tableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        action.addAction(ok)
        action.addAction(cancel)
        
        self.present(action, animated: false)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell identifier가 없을 경우 UITableViewCell 인스턴스를 생성한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) ?? UITableViewCell()
        // cell의 라인 제한 풀어줌
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}
