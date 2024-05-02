//
//  MinesweeperCell+Square.swift
//  Minesweeper
//
//  Created by X_Tu on 2024/4/18.
//

import SwiftUI

extension MinesweeperCell {
    struct Square: Layout {
        func makeCache(subviews: Subviews) -> CGFloat {
            let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
            let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSize in
                CGSize(width: max(currentMax.width, subviewSize.width),
                       height: max(currentMax.height, subviewSize.height))
            }
            return max(maxSize.width, maxSize.height)
        }

        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache maxLength: inout CGFloat) -> CGSize {
            CGSize(width: maxLength, height: maxLength)
        }

        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache maxLength: inout CGFloat) {
            let placementProposal = ProposedViewSize(width: maxLength, height: maxLength)
            subviews.forEach { subview in
                subview.place(
                    at: CGPoint(x: bounds.midX, y: bounds.midY),
                    anchor: .center,
                    proposal: placementProposal)
            }
        }
    }
}
