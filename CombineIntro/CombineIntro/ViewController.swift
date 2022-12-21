//
//  ViewController.swift
//  CombineIntro
//
//  Created by photypeta-junha on 2022/12/16.
//

import Combine
import UIKit

// Publisher: 이벤트를 보낸다.
// Subscriber: Publisher를 구독한다.


class MyCustomTableViewCell: UITableViewCell {
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
//    let action = PassthroughSubject<> 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 10, y: 3, width: contentView.frame.size.width - 20, height: contentView.frame.size.height - 6)
    }
    
}

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MyCustomTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var models = [String]()
    
    var observer: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        
        observer = APICaller.shared.fetchCompanies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
                // 메모리 누수 방지
            }, receiveValue: { [weak self] value in
                self?.models = value
                self?.tableView.reloadData()
            })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCustomTableViewCell else { fatalError() }
        var content = cell.defaultContentConfiguration()
        content.text = models[indexPath.row]
//        cell.contentConfiguration = content
        return cell
    }
}
