//
//  Debouncer.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation

class Debouncer {
    var callback: (() -> Void)?
    var delay: Double
    weak var timer: Timer?

    init(delay: Double) {
        self.delay = delay
    }

    func call(callback: @escaping () -> Void) {
        self.callback = callback
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(fireNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }

    @objc func fireNow() {
        self.callback?()
    }
    
}
