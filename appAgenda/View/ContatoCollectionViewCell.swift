//
//  ContatoCollectionViewCell.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/7/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit

class ContatoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageviewCelula: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static func identifier() -> String {
        return "CelulaCollectionViewContatos"
    }
    
    func setupCelula(_ imagens: Imagens){
        guard let imagem = UIImage(data: imagens.imagem) else { return }
        imageviewCelula.image = imagem
    }
}

