//
//  CharacterCell.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
import UIKit
import SDWebImage

class CharacterCell: UITableViewCell {
    
    let frameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.masksToBounds = true // Ensure the corners are rounded
        return view
    }()
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    
    let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(frameView)
        frameView.addSubview(characterImageView)
        frameView.addSubview(nameLabel)
        frameView.addSubview(speciesLabel)
        
        // Auto Layout constraints for frameView
        frameView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Frame view constraints
            frameView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            frameView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            frameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            frameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Constraints for characterImageView
            characterImageView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: 16),
            characterImageView.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 80),
            characterImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Constraints for nameLabel
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -16),
            
            // Constraints for speciesLabel
            speciesLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            speciesLabel.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        
        if let imageURL = URL(string: character.image) {
            characterImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        }
        
        // Set background color based on character's status
        switch character.status.lowercased() {
        case "alive":
            frameView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1) // Light blue background for Alive
            frameView.layer.borderWidth = 0.0
        case "dead":
            frameView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.1) // Light pink background for Dead
            frameView.layer.borderWidth = 0.0
        default:
            frameView.backgroundColor = .clear // No color for Unknown
            frameView.layer.borderWidth = 1.0
        }
    }
}
