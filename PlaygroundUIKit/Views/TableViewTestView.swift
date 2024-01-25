//
//  TableViewTestView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/01/24.
//

import UIKit

enum TableViewCellEnum: Int, CaseIterable {
    case cell1
    case cell2
    case cell3
    case cell4
    case cell5
}

protocol TableViewTestViewDelegate: AnyObject {
    func updateTableViewHeight()
}

class TableViewTestView: UIView, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    // MARK: - Member
    var delegate: TableViewTestViewDelegate?
    
    var scrollView: UIScrollView = UIScrollView()
    var contentView: UIStackView = UIStackView()
    
    let tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
        tableView.isScrollEnabled = false
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: CGFloat.leastNormalMagnitude))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: CGFloat.leastNormalMagnitude))
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        return tableView
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ViewLoad
    func viewLoad() {
        contentView.axis = .vertical
        contentView.alignment = .fill
        contentView.distribution = .equalSpacing
        
        tableView.dataSource = self
        tableView.delegate = self
        contentView.addSubview(tableView)
        
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        
        // AutoLayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -500).isActive = true
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    
    // MARK: - DataSource(UITableView)
    /// セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewCellEnum.allCases.count
    }
    
    /// セクション内の行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /// セルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        switch indexPath.section {
            
        default:
            // テスト用セル
            let label: UILabel = UILabel()
            label.text = "hoge"
            
            cell.contentView.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10).isActive = true
            label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10).isActive = true
            label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20).isActive = true
            
            return cell
        }
    }
    
    
    // MARK: - Delegate(UITableView)
    /// セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /// ヘッダーの高さ
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    /// フッターの高さ
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
}
