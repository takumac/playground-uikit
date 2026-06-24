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
                rows: (0..<10).map { ListRowData(text: "\(title) - Row \($0)") }
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
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
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
/// UICollectionViewCompositionalLayout のヘッダー部分が、上端・下端の両方に積み重なるように拡張したクラス
/// 最終的には「ヘッダーの y 座標」の決定を書き換えているだけのクラス
/// ・通過済みセクションのヘッダー: 上端に積み上がる（前セクションのヘッダー分だけ下げる）
/// ・未到達セクション（まだ見えていない下方のセクション）のヘッダー: 下端に積み上がる（自分以降のヘッダー分だけ上げる）
/// ・両者は「本来位置を上ピンと下ピンの間にクランプする」一本の式で表現する
final class StackedHeaderCompositionalLayout: UICollectionViewCompositionalLayout {
    // MARK: - Override
    /// スクロールの際にレイアウトの更新（ヘッダーの y 座標の再計算）を行うために true を返却
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    /// 補足ビュー(ヘッダー、フッター等)のレイアウト情報(frame等)を返却
    /// ※各セクションのヘッダーが上端／下端にスタックされるようなレイアウト情報を設定して返す
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
        
        // 可視領域の上端／下端を取得（ナビゲーションバー、セーフエリア等を考慮）
        let visibleTop = cv.contentOffset.y + cv.adjustedContentInset.top
        let visibleBottom = cv.contentOffset.y + cv.bounds.height - cv.adjustedContentInset.bottom
        
        // 上ピン: このセクションを上端に止める位置（自分より前のセクションのヘッダー高さ合計だけ下げる）
        let topPinned = visibleTop + stackedHeaderHeight(before: indexPath.section)
        // 下ピン: このセクションを下端に止める位置（自分以降＝自分を含むヘッダー高さ合計だけ可視下端から上げる）
        let bottomPinned = visibleBottom - stackedHeaderHeight(fromInclusive: indexPath.section)
        
        // ヘッダーの位置を、本来位置を上ピンと下ピンの間にクランプして決定する
        // ・本来位置が上ピンより上（通過済み） → max により上ピンに固定（上端スタック）
        // ・本来位置が下ピンより下（未到達／まだ見えていない） → min により下ピンに固定（下端スタック）
        // ・その間（画面内に普通に居る） → 本来位置のまま流れる
        var frame = attrs.frame
        frame.origin.y = min(max(frame.origin.y, topPinned), bottomPinned)
        attrs.frame = frame
        
        // ヘッダーをセルより前面に表示
        // ※後のセクションほど手前になるような zIndex を指定（重なった場合の保険。実際は frame 計算でピッタリ揃うので重ならない）
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
        
        let sectionCount = collectionView?.numberOfSections ?? 0
        
        // 標準のレイアウト情報に含まれているヘッダーのセクションを取得
        var sectionsWithHeader = Set(
            result
                .filter { $0.representedElementKind == UICollectionView.elementKindSectionHeader }
                .map { $0.indexPath.section }
        )
        // 標準のレイアウト情報に含まれているセクション(セル、ヘッダー、何かしらが含まれている)を取得
        let visibleSections = result.map { $0.indexPath.section }
        
        // ===== 上方向のスタック補完（通過済みセクション）=====
        // 標準のレイアウト情報に含まれていない、表示範囲より上のセクションのヘッダー固定情報を追加
        // ※追加対象は topVisible = visibleSections.min() まで
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
        
        // ===== 下方向のスタック補完（未到達セクション：まだ見えていない下方のセクション）=====
        // 標準のレイアウト情報に含まれていない、表示範囲より下のセクションのヘッダー固定情報を追加
        // ※標準実装では rect 内（＝可視範囲付近）のヘッダーしか返ってこないため、下方に控えているセクションのヘッダーは自前で補完する必要がある
        // ※追加対象は bottomVisible = visibleSections.max() 以降の全セクション
        if let bottomVisible = visibleSections.max(), sectionCount > 0 {
            for section in bottomVisible..<sectionCount where !sectionsWithHeader.contains(section) {
                if let attrs = layoutAttributesForSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    at: IndexPath(item: 0, section: section)
                ) {
                    result.append(attrs)
                    sectionsWithHeader.insert(section)
                }
            }
        }
        
        // ===== 最終的に表示するヘッダーのレイアウト情報を確定 =====
        // ※前のループで追加された固定情報を考慮して、標準のレイアウト情報に含まれているヘッダーも再計算する必要があるため。
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
    /// 引数の section より前にある各セクションのヘッダーの高さの合計を算出（上端スタック用）
    private func stackedHeaderHeight(before section: Int) -> CGFloat {
        var total: CGFloat = 0
        for s in 0..<section {
            total += naturalHeaderFrame(forSection: s)?.height ?? 0
        }
        return total
    }
    
    /// 引数の section 以降（自分を含む）の各セクションのヘッダーの高さの合計を算出（下端スタック用）
    private func stackedHeaderHeight(fromInclusive section: Int) -> CGFloat {
        guard let count = collectionView?.numberOfSections, section < count else { return 0 }
        var total: CGFloat = 0
        for s in section..<count {
            total += naturalHeaderFrame(forSection: s)?.height ?? 0
        }
        return total
    }
    
    /// 本来のヘッダーの位置を取得
    /// ※Stack化しない場合にフレームワーク側が返却するヘッダーの frame を取得する（super から取得）
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
