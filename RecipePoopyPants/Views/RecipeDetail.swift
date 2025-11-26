//
//  RecipeDetail.swift
//  RecipePoopyPants
//
//  Created by Mike Brockman on 11/26/25.
//
import SwiftUI

struct RecipeDetail: View {
    let item: Recipe
    var compact: Bool = false
    @AppStorage("userName") private var userName: String = ""

    var body: some View {
        if compact {
            // List presentation
            VStack(alignment: .leading, spacing: K.padding * 0.5) {
                Text(item.title)
                    .font(.body)
                    .lineLimit(1)
                HStack(spacing: K.padding) {
                    if !userName.isEmpty {
                        Text("@\(userName)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
        } else {
            // Popover detailed presentation
            VStack(alignment: .leading, spacing: K.padding) {
                Text(item.title)
                    .font(.title2)
                    .bold()
                if !userName.isEmpty {
                    Text("@\(userName)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
            .navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RecipeDetail(item: Recipe(timestamp: Date(), title: "Testing"))
}
