//
//  Extensions.swift
//  Github
//
//  Created by Marko Antoljak on 2/14/23.
//

import Foundation
import UIKit

extension Int {
    
    func formatBigInt() -> String {
        if self >= 1000 {
            let calculatedNumber = Double(self) / 1000.0
            let roundedValue = floor(calculatedNumber * 10) / 10.0
            return "\(roundedValue)k"
        }
        return "\(self)"
    }
}

extension String {
    // formatting date(string) from the server
    func formatTimestamp() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'" // how the value looks like on the server
        guard let date = formatter.date(from:self) else {return nil}
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        formatter.timeZone = NSTimeZone(name: "GMT") as? TimeZone
        let formatedDateAsString = formatter.string(from: date)
        return formatedDateAsString
    }
}

extension UIView {
    func shakeAnimate() {
        let numberOfFrames: Double = 5
        let frameDuration = Double(1 / numberOfFrames)

        let angle = 0.1

        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: frameDuration) {
                self.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration, relativeDuration: frameDuration) {
                self.transform = CGAffineTransform(rotationAngle: angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 2, relativeDuration: frameDuration) {
                self.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 3, relativeDuration: frameDuration) {
                self.transform = CGAffineTransform(rotationAngle: angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 4, relativeDuration: frameDuration) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
