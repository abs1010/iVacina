//
//  PessoaCollectionViewCell.swift
//  iVacina
//
//  Created by Bruna Ferreira on 21/10/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import UIKit

class PessoaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var imagemPessoa: UIImageView!
    
    func setPessoa(pessoa: Pessoa){
        self.nomeLabel.text = pessoa.nome
        self.imagemPessoa.image = UIImage(named: pessoa.imagem)
    }
}
