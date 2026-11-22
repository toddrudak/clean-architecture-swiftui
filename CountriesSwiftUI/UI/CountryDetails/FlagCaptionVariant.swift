//
//  FlagCaptionVariant.swift
//  CountriesSwiftUI
//

import SwiftUI

/// Experiment `flag-caption-v1`: today's country details, with the caption 'Tap to enlarge'
/// shown above the flag's tap target while the flag is displayed.
struct FlagCaptionVariant<Content: View>: View {

    let showsCaption: Bool
    @ViewBuilder let content: Content

    var body: some View {
        content
            .safeAreaInset(edge: .top, spacing: 0) {
                if showsCaption {
                    Text("Tap to enlarge")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)
                }
            }
    }
}
