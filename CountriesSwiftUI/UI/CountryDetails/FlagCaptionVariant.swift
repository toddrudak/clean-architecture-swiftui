//
//  FlagCaptionVariant.swift
//  CountriesSwiftUI
//

import SwiftUI

/// Experiment `flag-caption-v1`: today's flag tap target with the caption 'Tap to enlarge' below it.
struct FlagCaptionVariant<FlagView: View>: View {

    private let flagView: () -> FlagView

    init(@ViewBuilder flagView: @escaping () -> FlagView) {
        self.flagView = flagView
    }

    var body: some View {
        VStack {
            flagView()
            Text("Tap to enlarge")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
