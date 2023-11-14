//
//  ResultViewController.swift
//  Contents-Convergence-Graduate-Project
//
//  Created by 김유나 on 2023/11/02.
//

import UIKit

enum SleepType: Character {
    case Best = "0"
    case Zombie = "1"
    case Baby = "2"
    case Nervous = "3"
    
    var typeText: String {
        switch self {
        case .Best:
            return TextLiteral.ResultView.babyTypeText
        case .Zombie:
            return TextLiteral.ResultView.zombieTypeText
        case .Baby:
            return TextLiteral.ResultView.babyTypeText
        case .Nervous:
            return TextLiteral.ResultView.nervousTypeText
        }
    }
    
    var angelText: String {
        switch self {
        case .Best:
            return TextLiteral.ResultView.bestAngelText
        case .Zombie:
            return TextLiteral.ResultView.zombieAngelText
        case .Baby:
            return TextLiteral.ResultView.babyAngelText
        case .Nervous:
            return TextLiteral.ResultView.nervousAngelText
        }
    }
    
    var favoriteText: String {
        switch self {
        case .Best:
            return TextLiteral.ResultView.bestFavoriteText
        case .Zombie:
            return TextLiteral.ResultView.zombieFavoriteText
        case .Baby:
            return TextLiteral.ResultView.babyFavoriteText
        case .Nervous:
            return TextLiteral.ResultView.nervousFavoriteText
        }
    }
    
    var contentText: String {
        switch self {
        case .Best:
            return TextLiteral.ResultView.bestContentText
        case .Zombie:
            return TextLiteral.ResultView.zombieContentText
        case .Baby:
            return TextLiteral.ResultView.babyContentText
        case .Nervous:
            return TextLiteral.ResultView.nervousContentText
        }
    }
    
    var routineBeforeArray: [String] {
        switch self {
        case .Best, .Baby:
            return TextLiteral.ResultView.shortRoutineBeforeArray
        case .Zombie, .Nervous:
            return TextLiteral.ResultView.longRoutineBeforeArray
        }
    }
    
    var routineAfterArray: [String] {
        switch self {
        case .Best, .Baby:
            return TextLiteral.ResultView.shortRoutineAfterArray
        case .Zombie, .Nervous:
            return TextLiteral.ResultView.longRoutineAfterArray
        }
    }
    
    var routineTableViewHeight: Int {
        switch self {
        case .Best, .Baby:
            return 350
        case .Zombie, .Nervous:
            return 470
        }
    }
}

final class ResultViewController: BaseViewController {
    
    let resultType: SleepType
    
    // MARK: - property
    
    private let backButton = BackButton()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.ResultView.subTitleText
        label.textColor = .fontBlack
        label.font = .m24
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontBlack
        label.font = .sb30
        return label
    }()
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .sb30
        return label
    }()
    private let angelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontBlack
        label.font = .r20
        label.numberOfLines = 0
        return label
    }()
    private let favoriteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    private let favoriteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontBlack
        label.font = .m18
        label.numberOfLines = 0
        return label
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontBlack
        label.font = .m16
        label.numberOfLines = 0
        return label
    }()
    private let routineLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.ResultView.routineText
        label.textColor = .fontBlack
        label.font = .sb20
        return label
    }()
    private let routineTableView = UITableView()
    private let mainButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.ResultView.mainButtonText
        button.isDisabled = false
        return button
    }()
    
    // MARK: - life cycle
    
    init(resultType: SleepType) {
        self.resultType = resultType
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRoutineTableView()
    }
    
    override func render() {
        [scrollView, mainButton].forEach { view.addSubview($0) }
        scrollView.addSubview(contentView)
        [subTitleLabel, titleLabel, emojiLabel, angelLabel, favoriteImage, favoriteLabel, contentLabel, routineLabel, routineTableView].forEach {
            contentView.addSubview($0)
        }
        
        mainButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(52)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(mainButton.snp.top).offset(-12)
        }
        
        contentView.snp.makeConstraints {
            $0.width.edges.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        angelLabel.snp.makeConstraints {
            $0.top.equalTo(emojiLabel.snp.bottom).offset(38)
            $0.centerX.equalToSuperview()
        }
        
        favoriteImage.snp.makeConstraints {
            $0.top.equalTo(angelLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        
        favoriteLabel.snp.makeConstraints {
            $0.top.equalTo(favoriteImage.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(favoriteLabel.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(26)
        }
        
        routineLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
        
        routineTableView.snp.makeConstraints {
            $0.top.equalTo(routineLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(resultType.routineTableViewHeight)
            $0.bottom.equalTo(-16)
        }
    }
    
    override func configUI() {
        titleLabel.text = resultType.typeText
        emojiLabel.text = "⏰😴😵💦"
        angelLabel.text = TextLiteral.ResultView.previousAngelText + resultType.angelText + TextLiteral.ResultView.afterAngelText
        angelLabel.applyFont(resultType.angelText, .sb20)
        angelLabel.textAlignment = .center
        favoriteImage.image = ImageLiteral.favoriteImage
        favoriteLabel.setTextWithLineHeight(text: resultType.favoriteText, lineHeight: 27)
        favoriteLabel.textAlignment = .center
        contentLabel.setTextWithLineHeight(text: resultType.contentText, lineHeight: 24)
        super.configUI()
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = TextLiteral.questionViewControllerTitle
        navigationController?.navigationBar.tintColor = .fontBlack
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.fontBlack, NSAttributedString.Key.font: UIFont.sb16]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setRoutineTableView() {
        routineTableView.delegate = self
        routineTableView.dataSource = self
        
        routineTableView.register(RoutineTableViewCell.self, forCellReuseIdentifier: RoutineTableViewCell.cellId)
        routineTableView.rowHeight = 60
        routineTableView.separatorStyle = .none
        routineTableView.isScrollEnabled = false
        routineTableView.sectionHeaderTopPadding = 8
    }
}

// MARK: - extension

extension ResultViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 17))
        let header = UILabel()
        header.text = section == 0 ? TextLiteral.ResultView.routineHeaderBefore : TextLiteral.ResultView.routineHeaderAfter
        header.textColor = .fontBlack
        header.font = .m14
        header.frame = CGRect(x: 26, y: 0, width: tableView.bounds.size.width, height: 17)
        headerView.addSubview(header)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 17
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? resultType.routineBeforeArray.count : resultType.routineAfterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = routineTableView.dequeueReusableCell(withIdentifier: RoutineTableViewCell.cellId, for: indexPath) as! RoutineTableViewCell
        cell.selectionStyle = .none
        cell.cellLabel.text = indexPath.section == 0 ? resultType.routineBeforeArray[indexPath.item] : resultType.routineAfterArray[indexPath.item]
        return cell
    }
}
