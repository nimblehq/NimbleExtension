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

    private let uiHostingViewCount: Int

    public init(uiHostingViewCount: Int = 2) {
        self.uiHostingViewCount = uiHostingViewCount
    }

    public func makeUIView(context: Context) -> UIView {
        return PresentCoverTransparentBackgroundView(uiHostingViewCount: uiHostingViewCount)
    }

    public func updateUIView(
        _ uiView: UIView,
        context: Context
    ) {}
}

public class PresentCoverTransparentBackgroundView: UIView {

    private let uiHostingViewName = "_UIHostingView"
    private let uiHostingViewCount: Int

    public init(uiHostingViewCount: Int) {
        self.uiHostingViewCount = uiHostingViewCount
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func didMoveToWindow() {
        super.didMoveToWindow()
        var superview = superview
        var traversedUIHostingView = 0
        while superview != nil && traversedUIHostingView < uiHostingViewCount {
            if superview?.backgroundColor != .clear {
                superview?.backgroundColor = .clear
                superview?.isOpaque = true
            }
            if String(describing: superview).contains(uiHostingViewName) {
                traversedUIHostingView += 1
            }
            superview = superview?.superview
        }
    }
}

extension View {

    public func presentCoverTransparentBackground(uiHostingViewCount: Int = 2) -> some View {
        PresentCoverTransparentView(uiHostingViewCount: uiHostingViewCount)
            .ignoresSafeArea(.all, edges: [.top, .horizontal])
            .overlay { self }
    }
}
