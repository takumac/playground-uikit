//
//  TableViewTestView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2024/01/24.
//

import UIKit

enum TableViewCellEnum: Int, CaseIterable {
    case cell1 = 0
    case cell2
    case cell3
    case cell4
    case cell5
    case cell6
    case cell7
    case cell8
    case cell9
    case cell10
}

protocol TableViewTestViewDelegate: AnyObject {
    func updateTableViewHeight()
}

class TableViewTestView: UIView, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    // MARK: - Member
    weak var delegate: TableViewTestViewDelegate?
    
    var scrollView: UIScrollView = UIScrollView()
    var contentView = UIView()
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
    init() {
        super.init(frame: .zero)
        viewLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ViewLoad
    func viewLoad() {
        scrollView.backgroundColor = .red
        contentView.backgroundColor = .blue
        tableView.dataSource = self
        tableView.delegate = self
        
        contentView.addSubview(tableView)
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        
        // AutoLayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -500),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
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
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
                label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10),
                label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20)
            ])
            
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
    
    /// セルのタップ時
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // 偶数行のセルはタップ不可（選択状態にしない）にする
        switch indexPath.section {
        case TableViewCellEnum.cell2.rawValue
            ,TableViewCellEnum.cell4.rawValue
            ,TableViewCellEnum.cell6.rawValue
            ,TableViewCellEnum.cell8.rawValue
            ,TableViewCellEnum.cell10.rawValue:
            return false
        default:
            return true
        }
    }
    
    /// 選択状態になった時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("row \(indexPath.section + 1) tapped")
    }
    
}
