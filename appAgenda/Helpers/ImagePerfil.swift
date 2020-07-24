//
//  ImagePerfilViewModel.swift
//  appAgenda
//
//  Created by Kaique Santos Souza on 7/8/20.
//  Copyright © 2020 Kaique Santos Souza. All rights reserved.
//

import UIKit

protocol imagePickerFotoSelecionada: AnyObject {
    func imagePickerFotoSelecionada(_ foto: UIImage)
}

class ImagePerfil: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Atributos
    weak var delegate: imagePickerFotoSelecionada?

    // MARK: - Metodos

     func imagePickerController(_ picker: UIImagePickerController,
                                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let foto = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
         delegate?.imagePickerFotoSelecionada(foto)
         picker.dismiss(animated: true, completion: nil)
     }
}
