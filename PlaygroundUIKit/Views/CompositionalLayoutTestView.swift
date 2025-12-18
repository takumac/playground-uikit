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
                let itemHeight: NSCollectionLayoutDimension = {
                    if #available(iOS 17.0, *) {
                        return .uniformAcrossSiblings(estimate: 100)
                    } else {
                        return .estimated(100)
                    }
                }()
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: itemHeight
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: itemHeight
                )
                let group: NSCollectionLayoutGroup = {
                    if #available(iOS 16.0, *) {
                        let group = NSCollectionLayoutGroup.horizontal(
                            layoutSize: groupSize,
                            repeatingSubitem: item,
                            count: 3
                        )
                        group.interItemSpacing = .fixed(8)
                        return group
                    } else {
                        let group = NSCollectionLayoutGroup.horizontal(
                            layoutSize: groupSize,
                            subitem: item,
                            count: 3
                        )
                        group.interItemSpacing = .fixed(8)
                        return group
                    }
                }()
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(
                    top: 4,
                    leading: 12,
                    bottom: 4,
                    trailing: 12
                )
                section.interGroupSpacing = 8
                return section
                
            case .instagram:
                let rowEstimate: CGFloat = 240
                let rowHeight: NSCollectionLayoutDimension = {
                    if #available(iOS 17.0, *) {
                        return .uniformAcrossSiblings(estimate: rowEstimate)
                    } else {
                        return .estimated(rowEstimate)
                    }
                }()
                
                // item
                let tallItemSize: NSCollectionLayoutSize = .init(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1)
                )
                let smallStackSize: NSCollectionLayoutSize = .init(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1)
                )
                let smallItemSize: NSCollectionLayoutSize = .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1/2)
                )
                
                // group
                let row1 = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: rowHeight
                    ),
                    subitems: [
                        makeItemInstagram(layoutSize: tallItemSize),
                        makeSmallStackInstagram(
                            layoutSize: smallStackSize,
                            subitems: [
                                makeItemInstagram(layoutSize: smallItemSize),
                                makeItemInstagram(layoutSize: smallItemSize)
                            ]
                        ),
                        makeSmallStackInstagram(
                            layoutSize: smallStackSize,
                            subitems: [
                                makeItemInstagram(layoutSize: smallItemSize),
                                makeItemInstagram(layoutSize: smallItemSize)
                            ]
                        )
                    ]
                )
                let row2 = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: rowHeight
                    ),
                    subitems: [
                        makeSmallStackInstagram(
                            layoutSize: smallStackSize,
                            subitems: [
                                makeItemInstagram(layoutSize: smallItemSize),
                                makeItemInstagram(layoutSize: smallItemSize)
                            ]
                        ),
                        makeSmallStackInstagram(
                            layoutSize: smallStackSize,
                            subitems: [
                                makeItemInstagram(layoutSize: smallItemSize),
                                makeItemInstagram(layoutSize: smallItemSize)
                            ]
                        ),
                        makeItemInstagram(layoutSize: tallItemSize)
                    ]
                )
                let groupHeight: NSCollectionLayoutDimension = {
                    if #available(iOS 17.0, *) {
                        return .uniformAcrossSiblings(estimate: rowEstimate * 2)
                    } else {
                        return .estimated(rowEstimate * 2)
                    }
                }()
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: groupHeight
                    ),
                    subitems: [row1, row2]
                )
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(
                    top: 4,
                    leading: 12,
                    bottom: 4,
                    trailing: 12
                )
                return section
                
            case .netflix:
                // item
                let itemHeight: NSCollectionLayoutDimension = {
                    if #available(iOS 17.0, *) {
                        return .uniformAcrossSiblings(estimate: 200)
                    } else {
                        return .estimated(200)
                    }
                }()
                let itemSize: NSCollectionLayoutSize = .init(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: itemHeight
                )
                
                // group
                let groupSize: NSCollectionLayoutSize = .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: itemHeight
                )
                let group: NSCollectionLayoutGroup = .horizontal(
                    layoutSize: groupSize,
                    subitems: [
                        makeItemNetflix(layoutSize: itemSize),
                        makeItemNetflix(layoutSize: itemSize),
                        makeItemNetflix(layoutSize: itemSize)
                    ]
                )
                group.interItemSpacing = .fixed(8)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(
                    top: 4,
                    leading: 12,
                    bottom: 4,
                    trailing: 12
                )
                section.interGroupSpacing = 8
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
        }
        
        func makeItemInstagram(layoutSize: NSCollectionLayoutSize) -> NSCollectionLayoutItem {
            return NSCollectionLayoutItem(layoutSize: layoutSize)
        }
        
        func makeSmallStackInstagram(layoutSize: NSCollectionLayoutSize, subitems: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
            return NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: subitems)
        }
        
        func makeItemNetflix(layoutSize: NSCollectionLayoutSize) -> NSCollectionLayoutItem {
            return NSCollectionLayoutItem(layoutSize: layoutSize)
        }
        
    }
    /// セグメント1のアイテムタイプ
    private enum ItemTypeSeg1: Hashable {
        case grid(id: UUID)
        case instagram(id: UUID)
        case netflix(id: UUID)
    }
    
    private var gridItemDatasSeg1: [GridCellData] = [
        GridCellData(id: UUID(), imageName: "seg1-grid-1", text: "grid 1"),
        GridCellData(id: UUID(), imageName: "seg1-grid-2", text: "grid 2"),
        GridCellData(id: UUID(), imageName: "seg1-grid-3", text: "grid 3"),
        GridCellData(id: UUID(), imageName: "seg1-grid-4", text: "grid 4"),
        GridCellData(id: UUID(), imageName: "seg1-grid-5", text: "grid 5"),
        GridCellData(id: UUID(), imageName: "seg1-grid-6", text: "grid 6"),
        GridCellData(id: UUID(), imageName: "seg1-grid-7", text: "grid 7"),
        GridCellData(id: UUID(), imageName: "seg1-grid-8", text: "grid 8"),
        GridCellData(id: UUID(), imageName: "seg1-grid-9", text: "grid 9"),
        GridCellData(id: UUID(), imageName: "seg1-grid-10", text: "grid 10"),
    ]
    private var instagramItemDatasSeg1: [InstagramCellData] = [
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-1"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-2"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-3"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-4"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-5"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-6"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-7"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-8"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-9"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-10"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-11"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-12"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-13"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-14"),
        InstagramCellData(id: UUID(), imageName: "seg1-instagram-15")
    ]
    private var netflixItemDatasSeg1: [NetflixCellData] = [
        NetflixCellData(id: UUID(), imageName: "seg1-netflix-1", text: "MI"),
        NetflixCellData(id: UUID(), imageName: "seg1-netflix-2", text: "ワイスピ"),
        NetflixCellData(id: UUID(), imageName: "seg1-netflix-3", text: "ハリポタ"),
        NetflixCellData(id: UUID(), imageName: "seg1-netflix-4", text: "サマーウォーズ"),
        NetflixCellData(id: UUID(), imageName: "seg1-netflix-5", text: "火垂るの墓"),
        NetflixCellData(id: UUID(), imageName: "seg1-netflix-6", text: "TP"),
        NetflixCellData(id: UUID(), imageName: "seg1-netflix-7", text: "少林サッカー"),
        NetflixCellData(id: UUID(), imageName: "seg1-netflix-8", text: "SW"),
        NetflixCellData(id: UUID(), imageName: "seg1-netflix-9", text: "クローズ"),
        NetflixCellData(id: UUID(), imageName: "seg1-netflix-10", text: "バイオ"),
        
    ]
    
    /// セグメント2のセクションタイプ
    private enum SectionTypeSeg2: Int, CaseIterable, Hashable {
        case grid
        
        func layoutSection() -> NSCollectionLayoutSection {
            switch self {
            case .grid:
                // item
                let itemHeight: NSCollectionLayoutDimension = {
                    if #available(iOS 17.0, *) {
                        return .uniformAcrossSiblings(estimate: 100)
                    } else {
                        return .estimated(100)
                    }
                }()
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/2),
                    heightDimension: itemHeight
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                // group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: itemHeight
                )
                let group: NSCollectionLayoutGroup = {
                    if #available(iOS 16.0, *) {
                        let group = NSCollectionLayoutGroup.horizontal(
                            layoutSize: groupSize,
                            repeatingSubitem: item,
                            count: 2
                        )
                        group.interItemSpacing = .fixed(8)
                        return group
                    } else {
                        let group = NSCollectionLayoutGroup.horizontal(
                            layoutSize: groupSize,
                            subitem: item,
                            count: 2
                        )
                        group.interItemSpacing = .fixed(8)
                        return group
                    }
                }()
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(
                    top: 4,
                    leading: 12,
                    bottom: 4,
                    trailing: 12
                )
                section.interGroupSpacing = 8
                return section
            }
        }
    }
    /// セグメント2のアイテムタイプ
    private enum ItemTypeSeg2: Hashable {
        case grid(id: UUID)
    }
    
    private var gridItemDatasSeg2: [GridCellData] = [
        GridCellData(id: UUID(), imageName: "seg2-grid-1", text: "grid 1"),
        GridCellData(id: UUID(), imageName: "seg2-grid-2", text: "grid 2"),
        GridCellData(id: UUID(), imageName: "seg2-grid-3", text: "grid 3"),
        GridCellData(id: UUID(), imageName: "seg2-grid-4", text: "grid 4"),
        GridCellData(id: UUID(), imageName: "seg2-grid-5", text: "grid 5"),
        GridCellData(id: UUID(), imageName: "seg2-grid-6", text: "grid 6")
    ]
    
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
                    case .grid(let id):
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.identifier, for: indexPath) as! GridCell
                        if let data = self.gridItemDatasSeg1.first(where: { $0.id == id }) {
                            cell.configure(imageName: data.imageName, text: data.text)
                        }
                        return cell
                    case .instagram(let id):
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstagramCell.identifier, for: indexPath) as! InstagramCell
                        if let data = self.instagramItemDatasSeg1.first(where: { $0.id == id }) {
                            cell.configure(imageName: data.imageName)
                        }
                        return cell
                    case .netflix(let id):
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NetflixCell.identifier, for: indexPath) as! NetflixCell
                        if let data = self.netflixItemDatasSeg1.first(where: { $0.id == id }) {
                            cell.configure(imageName: data.imageName, text: data.text)
                        }
                        return cell
                    }
                    
                case .seg2(let subItem):
                    switch subItem {
                    case .grid(let id):
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.identifier, for: indexPath) as! GridCell
                        if let data = self.gridItemDatasSeg2.first(where: { $0.id == id }) {
                            cell.configure(imageName: data.imageName, text: data.text)
                        }
                        return cell
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
        snapshot.appendItems(
            gridItemDatasSeg1.map { .seg1(.grid(id: $0.id)) },
            toSection: .seg1(.grid)
        )
        snapshot.appendItems(
            instagramItemDatasSeg1.map { .seg1(.instagram(id: $0.id)) },
            toSection: .seg1(.instagram)
        )
        snapshot.appendItems(
            netflixItemDatasSeg1.map { .seg1(.netflix(id: $0.id)) },
            toSection: .seg1(.netflix)
        )
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
        snapshot.appendItems(
            gridItemDatasSeg2.map { .seg2(.grid(id: $0.id)) },
            toSection: .seg2(.grid)
        )
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


// MARK: - Cells
final class GridCell: UICollectionViewCell {
    // MARK: - Member
    static var identifier: String { "GridCell" }
    private let imageView = UIImageView()
    private let label = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        
        label.textAlignment = .center
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - configure
    func configure(imageName: String, text: String) {
        imageView.image = UIImage(named: imageName)
        label.text = text
    }
}

final class InstagramCell: UICollectionViewCell {
    // MARK: - Member
    static var identifier: String { "InstagramCell" }
    private let imageView = UIImageView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - configure
    func configure(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}

final class NetflixCell: UICollectionViewCell {
    // MARK: - Member
    static var identifier: String { "NetflixCell" }
    private let imageView = UIImageView()
    private let label = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        contentView.addSubview(label)
        
        contentView.backgroundColor = .darkGray
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - configure
    func configure(imageName: String, text: String) {
        imageView.image = UIImage(named: imageName)
        label.text = text
    }
}


// MARK: - Data Model Definition
struct GridCellData {
    let id: UUID
    let imageName: String
    let text: String
}

struct InstagramCellData {
    let id: UUID
    let imageName: String
}

struct NetflixCellData {
    let id: UUID
    let imageName: String
    let text: String
}
