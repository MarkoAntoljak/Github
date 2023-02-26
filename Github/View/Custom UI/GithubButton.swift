//
//  GithubButton.swift
//  Github
//
//  Created by Marko Antoljak on 2/22/23.
//

import UIKit

class GithubButton: UIButton {

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.blueColor
        setTitle("Open in browser", for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 20
    }
    required init(coder: NSCoder) {
        fatalError()
    }

}
