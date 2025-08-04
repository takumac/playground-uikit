//
//  CompositionalLayoutTestView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2025/07/08.
//

import UIKit

class CompositionalLayoutTestView: UIView {
    
    // MARK: - Enum
    /// セグメントタイプ
    private enum SegmentType: Int, CaseIterable {
        case segment1, segment2, segment3
        
        var backgroundColor: UIColor {
            switch self {
            case .segment1: return .white
            case .segment2: return .gray
            case .segment3: return .black
            }
        }
    }
    
    private enum SectionType: Hashable {
        case seg1(SectionTypeSeg1)
        case seg2(SectionTypeSeg2)
    }
    
    private enum ItemType: Hashable {
        case seg1(ItemTypeSeg1)
        case seg2(ItemTypeSeg2)
    }
    
    /// セグメント1のセクションタイプ
    private enum SectionTypeSeg1: Int, CaseIterable, Hashable {
        case grid, instagram, netflix
        
        func layoutSection() -> NSCollectionLayoutSection {
            switch self {
            case .grid:
                // item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(60))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 6, leading: 6, bottom: 6, trailing: 6)
                // group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(72))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                // section
                return NSCollectionLayoutSection(group: group)
                
            case .instagram:
                // item
                let big = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.66), heightDimension: .fractionalHeight(1)))
                big.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
                let small = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
                small.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
                // group
                let vertical = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1)),
                    subitem: small,
                    count: 2
                )
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [big, vertical])
                // section
                return NSCollectionLayoutSection(group: group)
                
            case .netflix:
                // item
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(120), heightDimension: .absolute(180)))
                item.contentInsets = .init(top: 6, leading: 6, bottom: 6, trailing: 6)
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .estimated(500), heightDimension: .absolute(192)),
                    subitems: [item]
                )
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }
        }
    }
    /// セグメント1のアイテムタイプ
    private enum ItemTypeSeg1: Hashable {
        case grid(text: String)
        case instagram(text: String)
        case netflix(text: String)
    }
    
    private var gridItemDatasSeg1: [String] = ["Grid 1", "Grid 2", "Grid 3", "Grid 4", "Grid 5", "Grid 6", "Grid 7", "Grid 8", "Grid 9", "Grid 10"]
    private var instagramItemDatasSeg1: [String] = ["Instagram 1", "Instagram 2", "Instagram 3", "Instagram 4", "Instagram 5", "Instagram 6", "Instagram 7", "Instagram 8", "Instagram 9", "Instagram 10"]
    private var netflixItemDatasSeg1: [String] = ["Netflix 1", "Netflix 2", "Netflix 3", "Netflix 4", "Netflix 5", "Netflix 6", "Netflix 7", "Netflix 8", "Netflix 9", "Netflix 10"]
    
    /// セグメント2のセクションタイプ
    private enum SectionTypeSeg2: Int, CaseIterable, Hashable {
        case grid
        
        func layoutSection() -> NSCollectionLayoutSection {
            switch self {
            case .grid:
                // item
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/2),
                    heightDimension: .absolute(80)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
                // group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(88)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                // section
                return NSCollectionLayoutSection(group: group)
            }
        }
    }
    /// セグメント2のアイテムタイプ
    private enum ItemTypeSeg2: Hashable {
        case grid(text: String)
    }
    
    private var gridItemDatasSeg2: [String] = ["Grid 1", "Grid 2", "Grid 3", "Grid 4", "Grid 5", "Grid 6"]
    
    /// セグメント3のセクションタイプ
    private enum SectionTypeSeg3: Int, CaseIterable, Hashable {
        case instagram
    }
    
    // MARK: - Member
    /// CollectionView
    private var collectionView: UICollectionView!
    /// データソース
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, ItemType>!
    /// セグメントコントロール
    private let segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Segment1", "Segment2", "Segment3"])
        control.selectedSegmentIndex = 0
        return control
    }()
    /// 現在選択されているセグメント
    private var currentSegment: SegmentType = .segment1 {
        didSet {
            applyLayout()
        }
    }
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // UI設定
        setupView()
        // データソース設定
        setupDataSource()
        // 初期反映
        applyLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .white
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: "GridCell")
        collectionView.register(InstagramCell.self, forCellWithReuseIdentifier: "InstagramCell")
        collectionView.register(NetflixCell.self, forCellWithReuseIdentifier: "NetflixCell")
        
        addSubview(segmentControl)
        addSubview(collectionView)
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 8).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        segmentControl.addTarget(self, action: #selector(didChangeSegment(_:)), for: .valueChanged)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .seg1(let subItem):
                    switch subItem {
                    case .grid(let text):
                        return collectionView.dequeueConfigured(GridCell.self, item: text, indexPath: indexPath)
                    case .instagram(let text):
                        return collectionView.dequeueConfigured(InstagramCell.self, item: text, indexPath: indexPath)
                    case .netflix(let text):
                        return collectionView.dequeueConfigured(NetflixCell.self, item: text, indexPath: indexPath)
                    }
                    
                case .seg2(let subItem):
                    switch subItem {
                    case .grid(let text):
                        return collectionView.dequeueConfigured(GridCell.self, item: text, indexPath: indexPath)
                    }
                }
            }
        )
    }
    
    
    // MARK: - Action
    @objc private func didChangeSegment(_ sender: UISegmentedControl) {
        currentSegment = SegmentType(rawValue: sender.selectedSegmentIndex) ?? .segment1
    }
    
    
    // MARK: - Layout(CollectionView)
    private func applyLayout() {
        switch currentSegment {
        case .segment1:
            collectionView.backgroundColor = currentSegment.backgroundColor
            collectionView.setCollectionViewLayout(createLayoutSeg1(), animated: true)
            applyDataSeg1()
            
        case .segment2:
            collectionView.backgroundColor = currentSegment.backgroundColor
            collectionView.setCollectionViewLayout(createLayoutSeg2(), animated: true)
            applyDataSeg2()
            
        case .segment3:
            break
        }
    }
    
    /// セグメント1のレイアウト設定
    private func createLayoutSeg1() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            guard let sectionType = SectionTypeSeg1(rawValue: sectionIndex) else {
                // デフォルトレイアウト（データが存在しないため非表示）
                let item = NSCollectionLayoutItem(layoutSize:
                        .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(10)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                        .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(10)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
            return sectionType.layoutSection()
        })
    }
    
    /// セグメント1のデータ設定
    private func applyDataSeg1() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.seg1(.grid), .seg1(.instagram), .seg1(.netflix)])
        snapshot.appendItems(gridItemDatasSeg1.map { .seg1(.grid(text: $0)) }, toSection: .seg1(.grid))
        snapshot.appendItems(instagramItemDatasSeg1.map { .seg1(.instagram(text: $0)) }, toSection: .seg1(.instagram))
        snapshot.appendItems(netflixItemDatasSeg1.map { .seg1(.netflix(text: $0)) }, toSection: .seg1(.netflix))
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    /// セグメント2のレイアウト設定
    private func createLayoutSeg2() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            guard let sectionType = SectionTypeSeg2(rawValue: sectionIndex) else {
                // デフォルトレイアウト（データが存在しないため非表示）
                let item = NSCollectionLayoutItem(layoutSize:
                        .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(10)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                        .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(10)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
            return sectionType.layoutSection()
        })
    }
    
    /// セグメント2のデータ設定
    private func applyDataSeg2() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.seg2(.grid)])
        snapshot.appendItems(gridItemDatasSeg2.map { .seg2(.grid(text: $0)) }, toSection: .seg2(.grid))
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


// MARK: - Cell helpers
protocol ConfigurableCell {
    static var identifier: String { get }
    func configure(text: String)
}


// MARK: - Cells
final class GridCell: UICollectionViewCell, ConfigurableCell {
    static var identifier: String { "GridCell" }
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textAlignment = .center
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(text: String) {
        label.text = text
    }
}

final class InstagramCell: UICollectionViewCell, ConfigurableCell {
    static var identifier: String { "InstagramCell" }
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(text: String) {
        label.text = text
    }
}

final class NetflixCell: UICollectionViewCell, ConfigurableCell {
    static var identifier: String { "NetflixCell" }
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        contentView.backgroundColor = .darkGray
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(text: String) {
        label.text = text
    }
}


// MARK: - Extension
private extension UICollectionView {
    func dequeueConfigured<T: UICollectionViewCell>(_ cellType: T.Type, item: String, indexPath: IndexPath) -> UICollectionViewCell? where T: ConfigurableCell {
        let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
        cell?.configure(text: item)
        return cell
    }
}


