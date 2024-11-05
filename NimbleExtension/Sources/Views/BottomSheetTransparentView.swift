//
//  PresentCoverTransparentView.swift
//  NimbleExtension
//
//  Copyright (c) 2019 Nimble
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import SwiftUI

public struct PresentCoverTransparentView: UIViewRepresentable {

    private let maxUIHostingViewsToTraverse: Int

    public init(maxUIHostingViewsToTraverse: Int = 2) {
        self.maxUIHostingViewsToTraverse = maxUIHostingViewsToTraverse
    }

    public func makeUIView(context: Context) -> UIView {
        return PresentCoverTransparentBackgroundView(maxUIHostingViewsToTraverse: maxUIHostingViewsToTraverse)
    }

    public func updateUIView(
        _ uiView: UIView,
        context: Context
    ) {}
}

public class PresentCoverTransparentBackgroundView: UIView {

    private let uiHostingViewName = "_UIHostingView"
    private let maxUIHostingViewsToTraverse: Int

    public init(maxUIHostingViewsToTraverse: Int) {
        self.maxUIHostingViewsToTraverse = maxUIHostingViewsToTraverse
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func didMoveToWindow() {
        super.didMoveToWindow()
        var currentSuperview = superview
        var traversedCount = 0
        while let superview = currentSuperview, traversedCount < maxUIHostingViewsToTraverse {
            if superview.backgroundColor != .clear {
                superview.backgroundColor = .clear
                superview.isOpaque = true
            }
            if String(describing: superview).contains(uiHostingViewName) {
                traversedCount += 1
            }
            currentSuperview = superview?.superview
        }
    }
}

extension View {

    public func presentCoverTransparentBackground(maxUIHostingViewsToTraverse: Int = 2) -> some View {
        PresentCoverTransparentView(maxUIHostingViewsToTraverse: maxUIHostingViewsToTraverse)
            .ignoresSafeArea(.all, edges: [.top, .horizontal])
            .overlay { self }
    }
}
