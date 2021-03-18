//
//  LoadingView.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.03.2021.
//

import UIKit

struct LoadingView {
    //MARK: - Views
    private let bluredView: UIView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    }()
    
    
    //MARK: - addConstraints
    func addConstraints(){
        bluredView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    var view: UIView {
        return bluredView
    }
}
