//
//  NSSwitcher.swift
//  Switcher
//
//  Created by Rui Aureliano on 07/01/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

@IBDesignable open class Switcher: NSControl {

    @IBInspectable public var state: Bool = false
    @IBInspectable public var onTint: NSColor = NSColor(red: 0.18, green: 0.50, blue: 0.99, alpha: 1.00)
    @IBInspectable public var offTint: NSColor = NSColor.labelColor.withAlphaComponent(0.1)
    @IBInspectable public var thumbTint: NSColor = NSColor(red: 1, green: 1, blue: 1, alpha: 1)

    private var switcherOverlay: SwitcherOverlay!

    open override func awakeFromNib() {
        super.awakeFromNib()
        switcherOverlay = SwitcherOverlay(frame: self.bounds)
        switcherOverlay.alphaValue = 0
        self.addSubview(switcherOverlay)
    }

    override open func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let bgbezier = NSBezierPath(
            roundedRect: NSRect(x: 2, y: 1, width: dirtyRect.size.width - 4, height: dirtyRect.size.height - 2),
            xRadius: (dirtyRect.size.height - 1) / 2,
            yRadius: (dirtyRect.size.height - 2) / 2
        )
        bgbezier.addClip()
        state ? onTint.setFill() : offTint.setFill()
        NSColor.labelColor.withAlphaComponent(0.15).setStroke()
        bgbezier.fill()
        bgbezier.stroke()

        let thumbBezier = NSBezierPath(ovalIn: NSRect(
            x: state ? dirtyRect.size.width - dirtyRect.size.height + 1: 3,
            y: 2,
            width: dirtyRect.size.height - 4,
            height: dirtyRect.size.height - 4
            )
        )
        thumbTint.setFill()
        thumbBezier.fill()
        thumbBezier.stroke()
    }

    open override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        switcherOverlay.animator().alphaValue = 1
    }

    open override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        switcherOverlay.animator().alphaValue = 0
        if let action = self.action {
            self.state = !self.state
            self.needsDisplay = true
            NSApp.sendAction(action, to: self.target, from: self)
        }
    }
}

class SwitcherOverlay: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let bezier = NSBezierPath(
            roundedRect: NSRect(x: 2, y: 1, width: dirtyRect.size.width - 4, height: dirtyRect.size.height - 2),
            xRadius: (dirtyRect.size.height - 1) / 2,
            yRadius: (dirtyRect.size.height - 2) / 2
        )
        bezier.addClip()
        NSColor.labelColor.withAlphaComponent(0.1).setFill()
        bezier.fill()
    }
}
