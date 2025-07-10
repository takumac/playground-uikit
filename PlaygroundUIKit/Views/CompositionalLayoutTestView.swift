//
//  CompositionalLayoutTestView.swift
//  PlaygroundUIKit
//
//  Created by Takumi Sakai on 2025/07/08.
//

import UIKit

class CompositionalLayoutTestView: UIView {
    
    // MARK: - Enum
    private enum LayoutType: Int, CaseIterable {
        case grid = 0, instagram, netflix
        
        var backgroundColor: UIColor {
            switch self {
            case .grid: return .white
            case .instagram: return .systemGray6
            case .netflix: return .black
            }
        }
        
        func items() -> [String] {
            switch self {
            case .grid: return (0..<8).map { "Grid \($0)" }
            case .instagram: return (0..<6).map { "Insta \($0)" }
            case .netflix: return (0..<10).map { "Movie \($0)" }
            }
        }
    }
    
    // MARK: - Member
    private var layoutType: LayoutType = .grid {
        didSet {
            applyLayout()
        }
    }
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    private let segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Grid", "Instagram", "Netflix"])
        control.selectedSegmentIndex = 0
        return control
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewLoad()
        layoutType = .grid
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func viewLoad() {
        backgroundColor = .white
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: "GridCell")
        collectionView.register(InstagramCell.self, forCellWithReuseIdentifier: "InstagramCell")
        collectionView.register(NetflixCell.self, forCellWithReuseIdentifier: "NetflixCell")
        setupDataSource()
        
        addSubview(segmentControl)
        addSubview(collectionView)
        
        // AutoLayout
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        segmentControl.addTarget(self, action: #selector(didChangeSegment(_:)), for: .valueChanged)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc private func didChangeSegment(_ sender: UISegmentedControl) {
        guard let type = LayoutType(rawValue: sender.selectedSegmentIndex) else { return }
        layoutType = type
    }
    
    private func applyLayout() {
        let layout = createLayout(for: layoutType)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = layoutType.backgroundColor
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(layoutType.items())
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let self = self else { return nil }
            switch self.layoutType {
            case .grid:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
                cell.configure(text: item)
                return cell
            case .instagram:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstagramCell", for: indexPath) as! InstagramCell
                cell.configure(text: item)
                return cell
            case .netflix:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NetflixCell", for: indexPath) as! NetflixCell
                cell.configure(text: item)
                return cell
            }
        }
    }
    
    private func createLayout(for type: LayoutType) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            switch type {
            case .grid:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(60))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 6, leading: 6, bottom: 6, trailing: 6)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(72))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                return NSCollectionLayoutSection(group: group)
            case .instagram:
                let big = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.66), heightDimension: .fractionalHeight(1)))
                big.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
                let small = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
                small.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
                let vertical = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1)), subitem: small, count: 2)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [big, vertical])
                return NSCollectionLayoutSection(group: group)
            case .netflix:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(120), heightDimension: .absolute(180)))
                item.contentInsets = .init(top: 6, leading: 6, bottom: 6, trailing: 6)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(500), heightDimension: .absolute(192)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }
        }
    }
}

// MARK: - Cells (same as your previous definition)
class GridCell: UICollectionViewCell {
    
    // MARK: - Member
    private let label = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        
        self.contentView.backgroundColor = .systemGray5
        self.contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - configure
    func configure(text: String) {
        label.text = text
    }
}

class InstagramCell: UICollectionViewCell {
    
    // MARK: - Member
    private let imageView = UIView()
    private let label = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .systemPink
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -4).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - configure
    func configure(text: String) {
        label.text = text
    }
}

class NetflixCell: UICollectionViewCell {
    
    // MARK: - Member
    private let poster = UIView()
    private let label = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        poster.backgroundColor = .black
        
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        
        poster.addSubview(label)
        self.contentView.addSubview(poster)
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        poster.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        poster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        poster.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: poster.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: poster.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - configure
    func configure(text: String) {
        label.text = text
    }
}


