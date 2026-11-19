//
//  CountryDetailsFlagCaptionVariant.swift
//  CountriesSwiftUI
//
//  Variant of the country details for experiment `flag-caption-v1`:
//  the flag's tap target shows the caption "Tap to enlarge".
//

import SwiftUI

@MainActor
struct CountryDetailsFlagCaptionVariant: View {

    let country: DBModel.Country
    let details: Loadable<DBModel.CountryDetails>
    @Binding var detailsSheet: Bool
    let loadDetails: (_ forceReload: Bool) -> Void
    let cancelLoading: () -> Void
    let openFlag: () -> Void

    @Environment(\.locale) private var locale: Locale
    @Environment(\.injected) private var injected: DIContainer

    var body: some View {
        switch details {
        case .notRequested:
            Text("").onAppear {
                loadDetails(false)
            }
        case .isLoading:
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Button(action: {
                    cancelLoading()
                }, label: { Text("Cancel loading") })
            }
        case let .loaded(countryDetails):
            loadedView(countryDetails)
        case let .failed(error):
            ErrorView(error: error, retryAction: {
                loadDetails(true)
            })
        }
    }

    private func loadedView(_ countryDetails: DBModel.CountryDetails) -> some View {
        List {
            country.flag.map { url in
                flagView(url: url)
            }
            Section(header: Text("Basic Info")) {
                DetailRow(leftLabel: Text(country.alpha3Code), rightLabel: "Code")
                DetailRow(leftLabel: Text("\(country.population)"), rightLabel: "Population")
                DetailRow(leftLabel: Text("\(countryDetails.capital)"), rightLabel: "Capital")
            }
            if countryDetails.currencies.count > 0 {
                Section(header: Text("Currencies")) {
                    ForEach(countryDetails.currencies) { currency in
                        DetailRow(leftLabel: Text(currency.name + (currency.symbol.map { " " + $0 } ?? "")),
                                  rightLabel: Text(currency.code))
                    }
                }
            }
            if let neighbors = countryDetails.neighbors {
                if neighbors.count > 0 {
                    Section(header: Text("Neighboring countries")) {
                        ForEach(neighbors) { country in
                            NavigationLink(destination: CountryDetails(country: country)) {
                                DetailRow(leftLabel: Text(country.name(locale: locale)), rightLabel: "")
                            }
                        }
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .sheet2(isPresented: $detailsSheet,
                content: {
                    ModalFlagView(country: country, isDisplayed: $detailsSheet)
                        .inject(injected)
                })
    }

    private func flagView(url: URL) -> some View {
        HStack {
            Spacer()
            VStack {
                ImageView(imageURL: url)
                    .frame(width: 120, height: 80)
                    .onTapGesture {
                        openFlag()
                    }
                Text("Tap to enlarge")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}
