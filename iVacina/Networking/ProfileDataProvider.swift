//
//  ProfileDataProvider.swift
//  iVacina
//
//  Created by Alan Silva on 27/11/19.
//  Copyright © 2019 Alan Silva. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

protocol ProfileProviderDelegate {
    func successOnLoadingProfiles(titular: Titular?)
    func errorOnLoadingProfiles(error: Error?)
}

class ProfileProvider {
    
    var pessoa: Titular = Titular(nome: "Alan Silva", email: "", imagem: "", grupo: .Adulto, tipoSanguineo: .A, hipertenso: false, diabetico: false, doadorOrgaos: false, pcd: false,
                                  listaVacinas: [
                                    Vacina(nome: "BCG", grupo: .Crianca, status: false),
                                    Vacina(nome: "Hepatite_B", grupo: .Crianca, status: false),
                                    Vacina(nome: "Penta_1_Dose", grupo: .Crianca, status: false),
                                    Vacina(nome: "Poliomielite_1_Dose", grupo: .Crianca, status: false),
                                    Vacina(nome: "Poliomielite_2_Dose", grupo: .Crianca, status: false),
                                    Vacina(nome: "Poliomielite_3_Dose", grupo: .Crianca, status: false),
                                    Vacina(nome: "Pneumococica_10", grupo: .Crianca, status: false),
                                    Vacina(nome: "Rotavirus_Humano_1_Dose", grupo: .Crianca, status: false),
                                    Vacina(nome: "Meningococica_C", grupo: .Crianca, status: false),
                                    Vacina(nome: "Penta_2_Dose", grupo: .Crianca, status: false),
                                    Vacina(nome: "Pneumococica_10_Valente", grupo: .Crianca, status: false),
                                    Vacina(nome: "Rotavirus_Humano_2_Dose", grupo: .Crianca, status: false),
                                    Vacina(nome: "Febre_Amarela", grupo: .Crianca, status: false),
                                    Vacina(nome: "Triplice_Viral", grupo: .Crianca, status: false),
                                    Vacina(nome: "Pneumococica_Reforco", grupo: .Crianca, status: false),
                                    Vacina(nome: "Meningococica_Reforco", grupo: .Crianca, status: false),
                                    Vacina(nome: "Hepatite_A", grupo: .Crianca, status: false),
                                    Vacina(nome: "Tetra_Viral", grupo: .Crianca, status: false),
                                    Vacina(nome: "DTP", grupo: .Crianca, status: false),
                                    Vacina(nome: "Varicela", grupo: .Crianca, status: false),
                                    
                                    Vacina(nome: "HPV_1_Dose", grupo: .Adolescente, status: false),
                                    Vacina(nome: "HPV_2_Dose", grupo: .Adolescente, status: false),
                                    Vacina(nome: "Meningococica_C", grupo: .Adolescente, status: false),
                                    Vacina(nome: "Hepatite_B", grupo: .Adolescente, status: false),
                                    Vacina(nome: "Febre_Amarela_1_Dose", grupo: .Adolescente, status: false),
                                    Vacina(nome: "Dupla_Adulto_DT", grupo: .Adolescente, status: false),
                                    Vacina(nome: "Triplice_Viral", grupo: .Adolescente, status: false),
                                    Vacina(nome: "Pneumococica_23_Valente", grupo: .Adolescente, status: false),
                                    
                                    Vacina(nome: "Dupla_Adulto_DT", grupo: .Adulto, status: false),
                                    Vacina(nome: "Gripe", grupo: .Adulto, status: false),
                                    Vacina(nome: "Meningite_BACWY", grupo: .Adulto, status: false),
                                    Vacina(nome: "Hpv", grupo: .Adulto, status: false),
                                    Vacina(nome: "Pneumonia", grupo: .Adulto, status: false),
                                    Vacina(nome: "Herpes_Zoster", grupo: .Adulto, status: false),
                                    Vacina(nome: "Febre_Amarela", grupo: .Adulto, status: false),
                                    Vacina(nome: "Hepatite_B", grupo: .Adulto, status: false),
                                    Vacina(nome: "Triplice_Viral", grupo: .Adulto, status: false),
                                    Vacina(nome: "Hepatite_A", grupo: .Adulto, status: false),
                                    Vacina(nome: "Varicela", grupo: .Adulto, status: false),
                                    
                                    Vacina(nome: "Hepatite_B", grupo: .Idoso, status: false),
                                    Vacina(nome: "Febre_Amarela", grupo: .Idoso, status: false),
                                    Vacina(nome: "Dupla_Adulto_DT", grupo: .Idoso, status: false),
                                    Vacina(nome: "Pneumococica_23_Valente", grupo: .Idoso, status: false),
                                    Vacina(nome: "Gripe_Anual", grupo: .Idoso, status: false),
                                    
                                    Vacina(nome: "Hepatite_B", grupo: .Gestante, status: false),
                                    Vacina(nome: "Dupla_Adulto_DT", grupo: .Gestante, status: false),
                                    Vacina(nome: "dTpa", grupo: .Gestante, status: false),
                                    Vacina(nome: "Influenza", grupo: .Gestante, status: false)],
                                  
                                  dependentes: [])
    
    //================
    
    var delegate : ProfileProviderDelegate?
    private let uid = Auth.auth().currentUser
    
    func getProfileData(){
        
        //        let email = "alan@gmail.com"
        //        //if let email = self.uid?.email {
        //
        //        let formattedEmail = email.replacingOccurrences(of: ".", with: ",")
        //
        //        let user = Database.database().reference().child("user/profile/\(formattedEmail)")
        //
        //        user.observe(.value) { (userInformation) in
        //
        //            if let dictUser = userInformation.value as? [String:Any]{
        //                self.pessoa?.nome = dictUser["name"] as? String
        //                self.pessoa?.email = dictUser["email"] as? String
        //                self.pessoa?.hipertenso = dictUser["hipertenso"] as! Bool
        //                self.pessoa?.diabetico = dictUser["diabetico"] as! Bool
        //                self.pessoa?.doadorOrgaos = dictUser["doadorOrgaos"] as! Bool
        //                self.pessoa?.pcd = dictUser["pcd"] as! Bool
        //
        //            }
        //
        //        }
        
        self.delegate?.successOnLoadingProfiles(titular: pessoa)
        
    }
    
}
