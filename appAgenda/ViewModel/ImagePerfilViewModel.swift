//
//  ImagePerfilViewModel.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/8/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit

protocol imagePickerFotoSelecionada {
    func imagePickerFotoSelecionada(_ foto: UIImage) 
}
enum MenuOpcoes{
    case camera
    case galeria
    case cancelar
}

class ImagePerfilViewModel: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Atributos
    var delegate: imagePickerFotoSelecionada?
    
    // MARK: - Metodos
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let foto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        delegate?.imagePickerFotoSelecionada(foto)
        picker.dismiss(animated: true, completion: nil)
    }
    
     func menuDeOpcoes(completion:@escaping(_ opcao:MenuOpcoes) -> Void) -> UIAlertController {
           let menu = UIAlertController(title: "Menu", message: "escolha uma das opções abaixo!", preferredStyle: .actionSheet)
           let camera = UIAlertAction(title: "Tirar foto", style: .default) { (acao) in
               completion(.camera)
           }
           menu.addAction(camera)
           
           let galeria = UIAlertAction(title: "Galeria", style: .default) { (acao) in
               completion(.galeria)
           }
           menu.addAction(galeria)
           
           let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
           menu.addAction(cancelar)
           
           return menu
       }
    
    
    

}
