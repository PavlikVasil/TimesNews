//
//  ViewController.swift
//  TimesNews
//
//  Created by Павел on 18.02.2021.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var news: [StoreItem] = []
   
    
    func loadData(){
        let request = AF.request("https://api.nytimes.com/svc/topstories/v2/home.json?api-key=EvmLsE0QQRMCtGF96oXoi9aDhjOt4j26")
    
        request.validate().responseDecodable(of: StoreItems.self){(response) in
            guard let response = response.value else {return}
            self.news = response.results
            self.tableView.reloadData()
            print(self.news)
        }
    }
    
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.showActivityIndicator()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show"{
            print("show")
            let detailViewController = segue.destination as? DetailViewController
            let index = tableView.indexPathsForSelectedRows!.first!.row
            detailViewController?.item = news[index]
        }
    }
}


extension ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let item = news[indexPath.row]
        cell.titleLabel.text = item.title
        
        let dateComponents = item.updated_date.components(separatedBy: "T")
        let splitDate = dateComponents[0]
        cell.dateLabel.text = splitDate
        return cell
    }
}

extension UITableView {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .large)
            self.backgroundView = activityView
            activityView.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.backgroundView = nil
        }
    }
}
