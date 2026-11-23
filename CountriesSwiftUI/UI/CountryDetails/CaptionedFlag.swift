//
//  CaptionedFlag.swift
//  CountriesSwiftUI
//

import SwiftUI

/// Variant of experiment `flag-caption-v1`: today's flag tap target with a caption under it.
struct CaptionedFlag<Flag: View>: View {

    private let flag: Flag

    init(@ViewBuilder flag: () -> Flag) {
        self.flag = flag()
    }

    var body: some View {
        VStack {
            flag
            Text("Tap to enlarge")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
