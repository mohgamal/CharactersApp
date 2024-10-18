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
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10 // Adjust the corner radius for rounded rectangle effect
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold) // Bold font for name
        return label
    }()
    
    let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular) // Regular font for species
        label.textColor = .gray
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
        addSubview(characterImageView)
        addSubview(nameLabel)
        addSubview(speciesLabel)
        
        // Disable autoresizing mask and enable Auto Layout
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up Auto Layout constraints
        NSLayoutConstraint.activate([
            // Character image (rectangular image with rounded corners)
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 100),
            characterImageView.heightAnchor.constraint(equalToConstant: 100), // Rectangle shape
            
            // Name label
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Species label
            speciesLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            speciesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        
        if let imageURL = URL(string: character.image) {
            characterImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
