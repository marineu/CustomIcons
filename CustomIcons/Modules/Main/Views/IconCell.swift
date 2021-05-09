//
//  IconCell.swift
//  CustomIcons
//
//  Created by Marin Ipati on 09/05/2021.
//

import UIKit

class IconCell: UITableViewCell {
    
    var icon: Icon? {
        didSet {
            guard let icon = icon else {
                defaultValues()
                return
            }
            
            titleLabel.text    = icon.title
            subtitleLabel.text = icon.subtitle
            iconAsyncView.url = icon.image
        }
    }
    
    private var iconAsyncView: IconAsyncView = {
        let view = IconAsyncView()
        view.cornerRadius = 5
        view.scaleSize = CGSize(width: 100, height: 100)
        
        return view
    }()
    
    private var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        return lbl
    }()
    
    private var subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return lbl
    }()
    
    private var roundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        
        return view
    }()
    
    private var mainStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Constants.mainStackSpacing
        
        return stackView
    }()
    
    private var titlesStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defaultValues()
        addRoundView()
        addMainStackView()
        addIconAsyncView()
        mainStackView.addArrangedSubview(titlesStackView)
        addTitlesLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        defaultValues()
    }
    
    // MARK:  - setup UI
    
    private func addRoundView() -> Void {
        contentView.addSubview(roundView)
        
        roundView.translatesAutoresizingMaskIntoConstraints = false
        
        roundView.topAnchor
            .constraint(equalTo: contentView.topAnchor, constant: 5)
            .isActive = true
        
        roundView.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 15)
            .isActive = true
        
        contentView.bottomAnchor
            .constraint(equalTo: roundView.bottomAnchor, constant: 5)
            .isActive = true
        
        contentView.trailingAnchor
            .constraint(equalTo: roundView.trailingAnchor, constant: 15)
            .isActive = true
    }
    
    private func addMainStackView() -> Void {
        roundView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.topAnchor
            .constraint(equalTo: roundView.topAnchor, constant: 15)
            .isActive = true
        
        mainStackView.leadingAnchor
            .constraint(equalTo: roundView.leadingAnchor, constant: 8)
            .isActive = true
        
        roundView.bottomAnchor
            .constraint(equalTo: mainStackView.bottomAnchor, constant: 15)
            .isActive = true
        
        roundView.trailingAnchor
            .constraint(equalTo: mainStackView.trailingAnchor, constant: 8)
            .isActive = true
    }
    
    private func addIconAsyncView() -> Void {
        mainStackView.addArrangedSubview(iconAsyncView)
        
        iconAsyncView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconSize = Constants.iconSize
        
        iconAsyncView.heightAnchor
            .constraint(equalToConstant: iconSize.height).isActive = true
        iconAsyncView.widthAnchor
            .constraint(equalToConstant: iconSize.width).isActive = true
    }
    
    private func addTitlesLabel() -> Void {
        titlesStackView.addArrangedSubview(titleLabel)
        titlesStackView.addArrangedSubview(subtitleLabel)
    }
    
    // MARK: - private methods
    
    private func defaultValues() -> Void {
        titleLabel.text    = "No title"
        subtitleLabel.text = "No subtitle"
        iconAsyncView.url  = nil
    }
    
}
