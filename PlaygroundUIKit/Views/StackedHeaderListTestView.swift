//
//  StackedHeaderListTestView.swift
//  PlaygroundUIKit
//
//  Created by sakai on 2026/06/08.
//

import UIKit

// MARK: - StackedHeaderListTestView
class StackedHeaderListTestView: UIView {
    // MARK: - Enum
    /// セクションタイプ（識別子は id のみ）
    private enum SectionType: Hashable {
        case list(id: UUID)
        
        /// セクションのレイアウト定義
        func layoutSection(rowHeight: CGFloat, headerHeight: CGFloat) -> NSCollectionLayoutSection {
            switch self {
            case .list:
                // item
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(rowHeight)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // group（1行1セルのリスト）
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: itemSize,
                    subitems: [item]
                )
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                
                // header（自前で固定するので pinToVisibleBounds は false）
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(headerHeight)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                header.pinToVisibleBounds = false
                section.boundarySupplementaryItems = [header]
                
                return section
            }
        }
    }
    /// アイテムタイプ（データを直接持つ）
    private enum ItemType: Hashable {
        case listRow(ListRowData)
    }
    
    // MARK: - Member
    /// CollectionView
    private var collectionView: UICollectionView!
    /// データソース
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, ItemType>!
    
    /// ヘッダー高さ（積み上げ計算で一律前提に使う）
    private let headerHeight: CGFloat = 44
    /// 行の高さ
    private let rowHeight: CGFloat = 56
    
    /// リスト表示用の固定データ
    private let sectionDatas: [ListSectionData] = {
        let titles = ["Section A", "Section B", "Section C", "Section D", "Section E"]
        return titles.map { title in
            ListSectionData(
                title: title,
                rows: (0..<8).map { ListRowData(text: "\(title) - Row \($0)") }
            )
        }
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        // UI設定
        setupView()
        // データソース設定
        setupDataSource()
        // 初期反映
        applyData()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .systemBackground
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            ListRowCell.self,
            forCellWithReuseIdentifier: ListRowCell.identifier
        )
        collectionView.register(
            StackedHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StackedHeaderView.identifier
        )
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupDataSource() {
        // アイテム
        dataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ListRowCell.identifier,
                    for: indexPath) as! ListRowCell
                switch item {
                case .listRow(let data):
                    cell.configure(text: data.text)
                }
                return cell
            }
        )
        // ヘッダー
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self, kind == UICollectionView.elementKindSectionHeader else { return nil }
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: StackedHeaderView.identifier,
                for: indexPath) as! StackedHeaderView
            
            header.section = indexPath.section
            header.titleLabel.text = self.sectionDatas[indexPath.section].title
            header.onTap = { [weak self] section in
                self?.scrollToSection(section)
            }
            return header
        }
    }
    
    private func applyData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections(sectionDatas.map { .list(id: $0.id) })
        for section in sectionDatas {
            snapshot.appendItems(
                section.rows.map { .listRow($0) },
                toSection: .list(id: section.id)
            )
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - Layout(CollectionView)
    private func createLayout() -> UICollectionViewLayout {
        let rowHeight = self.rowHeight
        let headerHeight = self.headerHeight
        
        let layout = StackedHeaderCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            // 該当セクションの SectionType を取り出して、その SectionType に応じたレイアウト定義を用いる
            let sectionType = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            return sectionType.layoutSection(rowHeight: rowHeight, headerHeight: headerHeight)
        })
        return layout
    }
    
    // MARK: - Action
    /// セクションヘッダーのタップアクション
    /// 上に積み重なる固定ヘッダー分を差し引いて、対象セクションが固定ヘッダー群の直下に来るようにする
    private func scrollToSection(_ section: Int) {
        guard section >= 0, section < collectionView.numberOfSections else { return }
        guard collectionView.numberOfItems(inSection: section) > 0,
              let attr = collectionView.layoutAttributesForItem(at: IndexPath(item: 0, section: section))
        else { return }
        
        let insetTop = collectionView.adjustedContentInset.top
        var targetY = attr.frame.minY - CGFloat(section + 1) * headerHeight - insetTop
        
        let minY = -insetTop
        let maxY = max(
            minY,
            collectionView.contentSize.height - collectionView.bounds.height + collectionView.adjustedContentInset.bottom
        )
        targetY = min(max(targetY, minY), maxY)
        
        collectionView.setContentOffset(CGPoint(x: 0, y: targetY), animated: true)
    }
}


// MARK: - StackedHeaderCompositionalLayout
/// UICollectionviewCompositionalLayoutのヘッダー部分が積み重なるように拡張したクラス
/// 最終的には「ヘッダーのy座標」の決定を書き換えているだけのクラス
final class StackedHeaderCompositionalLayout: UICollectionViewCompositionalLayout {
    // MARK: - Override
    /// スクロールの際にレイアウトの更新（ヘッダーのy座標の再計算）を行うためにtrueを返却
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    /// 補足ビュー(ヘッダー、フッター等)のレイアウト情報(frame等)を返却
    /// ※各セクションのヘッダーがスタックされるようなレイアウト情報を設定して返す
    override func layoutAttributesForSupplementaryView(
        ofKind elementKind: String,
        at indexPath: IndexPath
    ) -> UICollectionViewLayoutAttributes? {
        // フレームワーク側の返却する標準のレイアウト情報を取得
        let base = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        
        // ヘッダーのレイアウト情報が返却されていない、もしくは、複製できない場合は、返却値をそのままリターン
        // ※ヘッダー以外(フッター等)の補足ビューのレイアウト設定でも本メソッドが用いられるため、ヘッダーのレイアウト情報であることを確認している
        // ※標準のレイアウト情報は内部で使い回される可能性があるため直接書き換えるとレイアウト情報が壊れる可能性がある。そのため複製する。
        guard elementKind == UICollectionView.elementKindSectionHeader,
              let cv = collectionView,
              let attrs = base?.copy() as? UICollectionViewLayoutAttributes
        else {
            return base
        }
        
        // CollectionViewのスクロール位置を取得(ナビゲーションバー、セーフエリア等を考慮)
        let offsetY = cv.contentOffset.y + cv.adjustedContentInset.top
        // このメソッドが呼ばれたセクションのヘッダーを止める位置のtopを計算
        let pinnedTop = offsetY + stackedHeight(before: indexPath.section)
        
        // このメソッドが呼ばれた呼ばれたセクションのヘッダーの位置を指定(ヘッダーの固定化処理。このセクションより前のセクションの固定化分も考慮。)
        var frame = attrs.frame
        frame.origin.y = max(frame.origin.y, pinnedTop)
        attrs.frame = frame
        
        // ヘッダーをセルより前面に表示
        // ※後のセクションほど手前になるようなzIndexを指定
        // ※後のセクションほど手前になる設定は重なった場合の保険。実際はframeを計算して前のセクションのヘッダーの下部とピッタリに位置するためヘッダー同士が重なる事はない。
        attrs.zIndex = 1000 + indexPath.section
        return attrs
    }
    
    /// 現在画面に表示している範囲に表示すべき要素(セル、ヘッダー、フッター等)のレイアウト情報を返却
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 現在の表示範囲に対してフレームワーク側が返却する標準のレイアウト情報を取得
        guard let base = super.layoutAttributesForElements(in: rect) else { return nil }
        
        // 標準のレイアウト情報を複製して保持
        // ※標準のレイアウト情報は内部で使い回される可能性があるため直接書き換えるとレイアウト情報が壊れる可能性がある。そのため複製する。
        var result = base.compactMap { $0.copy() as? UICollectionViewLayoutAttributes }
        
        // 標準のレイアウト情報で取得できる内容にはスタックしているヘッダー分のレイアウト情報が含まれていないので補完する
        // ※標準のレイアウト前提で、引数のrect内に含まれるCollectionView上の情報しか取得できないため。ヘッダーのスタック化はカスタマイズで実現しているため。
        
        // 標準のレイアウト情報に含まれているヘッダーのセクションを取得
        var sectionsWithHeader = Set(
            result
                .filter { $0.representedElementKind == UICollectionView.elementKindSectionHeader }
                .map { $0.indexPath.section }
        )
        // 標準のレイアウト情報に含まれているセクション(セル、ヘッダー、フッター、何かしらが含まれている)を取得
        let visibleSections = result.map { $0.indexPath.section }
        
        // 標準のレイアウト情報に含まれていないセクションのヘッダーの固定情報を追加
        // ※追加するセクションのヘッダーは現在の表示範囲より前のセクションを対象とする(topVisible = visibleSections.min())
        // ※ループ条件が section in 0...topVisible だが、見えている一番上のセクションは標準レイアウトとしてフレームワーク側が返却する。
        // ※そのため sectionsWithHeader に含まれるため実質的に問題はない。
        if let topVisible = visibleSections.min() {
            for section in 0...topVisible where !sectionsWithHeader.contains(section) {
                if let attrs = layoutAttributesForSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    at: IndexPath(item: 0, section: section)
                ) {
                    result.append(attrs)
                    sectionsWithHeader.insert(section)
                }
            }
        }
        
        // 最終的に表示するヘッダーのレイアウト情報を設定
        // ※前のループにて標準のレイアウト情報に含まれていないセクションのヘッダーの固定情報が追加されている。
        // ※追加されたヘッダーの固定情報を考慮して、標準のレイアウト情報に含まれているヘッダーのレイアウト情報を決める必要があるため。
        for attrs in result where attrs.representedElementKind == UICollectionView.elementKindSectionHeader {
            if let pinned = layoutAttributesForSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                at: attrs.indexPath
            ) {
                attrs.frame = pinned.frame
                attrs.zIndex = pinned.zIndex
            }
        }
        
        return result
    }
    
    // MARK: - Helper
    /// 引数の section より前にある各セクションのヘッダーの高さの合計を算出
    private func stackedHeight(before section: Int) -> CGFloat {
        var total: CGFloat = 0
        for s in 0..<section {
            total += naturalHeaderFrame(forSection: s)?.height ?? 0
        }
        return total
    }
    
    /// 本来のヘッダーの位置を取得
    /// ※Stack化しない場合にフレームワーク側が返却するヘッダーのframeを取得する
    /// ※superから取得する
    private func naturalHeaderFrame(forSection section: Int) -> CGRect? {
        return super.layoutAttributesForSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: section)
        )?.frame
    }
}


// MARK: - Cell
final class ListRowCell: UICollectionViewCell {
    
    // MARK: - Member
    static var identifier = "ListRowCell"
    private let label = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemBackground
        
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        let sep = UIView()
        sep.backgroundColor = .separator
        sep.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sep)
        NSLayoutConstraint.activate([
            sep.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            sep.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sep.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            sep.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - configure
    func configure(text: String) {
        label.text = text
    }
}


// MARK: - Header
final class StackedHeaderView: UICollectionReusableView {
    
    // MARK: - Member
    static var identifier = "StackedHeaderView"
    let titleLabel = UILabel()
    
    /// このヘッダーが属するセクション(再利用のたびに設定する)
    var section: Int = 0
    /// タップされたときに呼ばれる
    var onTap: ((Int) -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        let sep = UIView()
        sep.backgroundColor = .separator
        sep.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sep)
        NSLayoutConstraint.activate([
            sep.leadingAnchor.constraint(equalTo: leadingAnchor),
            sep.trailingAnchor.constraint(equalTo: trailingAnchor),
            sep.bottomAnchor.constraint(equalTo: bottomAnchor),
            sep.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        // タップ検知
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func handleTap() {
        onTap?(section)
    }
}


// MARK: - Data Model Definition
struct ListSectionData {
    let id = UUID()
    let title: String
    let rows: [ListRowData]
}

struct ListRowData: Hashable {
    let id = UUID()
    let text: String
}
