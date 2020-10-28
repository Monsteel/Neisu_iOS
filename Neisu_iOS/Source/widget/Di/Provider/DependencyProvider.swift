//
//  DependencyProvider.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 31/07/2020.
//

import Foundation
import Swinject

class DependencyProvider {
    
    let container = Container()
    let assembler: Assembler
    
    init(){
        Container.loggingFunction = nil
        assembler = Assembler(
            [
                RepositoryAssembly(),
                ReactorAssembly(),
                DataSourceAssembly(),
                UseCaseAssembly()
            ],
            container: container
        )
    }
}
