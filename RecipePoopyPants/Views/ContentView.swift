//
//  ContentView.swift
//  RecipePoopyPants
//
//  Created by Mike Brockman on 11/20/25.
//

import SwiftUI
import SwiftData

// ahh swiftui -- basically here's your react equivalent
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Recipe]
    @State private var showingNewRecipe = false
    @AppStorage("userName") private var userName: String = ""
    @State private var showingUserNamePrompt = false
    @State private var pendingUserName: String = ""

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        VStack(alignment: .leading, spacing: 8) {
                            RecipeDetail(item: item)
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            RecipeDetail(item: item, compact: true)
                        }
                        .lineLimit(1)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingUserNamePrompt = true
                    } label: {
                        let display = userName.isEmpty ? "Set Name" : "@\(userName)"
                        Label(display, systemImage: userName.isEmpty ? "person.badge.plus" : "person.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        showingNewRecipe = true
                    } label: {
                        Label("Add Recipe", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $showingNewRecipe) { // fkin hate sheets but here we are
            NewRecipeView()
        }
        .alert("Set your name", isPresented: $showingUserNamePrompt) {
            TextField("e.g. mike_poopy", text: $pendingUserName)
            Button("Save") {
                userName = pendingUserName.trimmingCharacters(in: .whitespacesAndNewlines)
                pendingUserName = ""
            }
            Button("Cancel", role: .cancel) {
                pendingUserName = ""
            }
        } message: {
            Text("This name will appear next to recipes you add.")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
