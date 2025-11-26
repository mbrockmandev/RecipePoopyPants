//
//  NewRecipeView.swift
//  RecipePoopyPants
//
//  Created by Mike Brockman on 11/26/25.
//
import SwiftUI
import SwiftData

struct NewRecipeView: View {
    // this lets swiftui dismiss the view when the entry is complete
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    // useState equivalent
    @State private var recipeName: String = ""
    @State private var ingredients: String = ""
    @State private var instructions: String = ""
    

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details").font(.headline)) {
                    TextField("Recipe Name", text: $recipeName)
                        .padding(.vertical, K.padding)
                }

                Section(header: Text("Ingredients").font(.headline)) {
                    TextEditor(text: $ingredients)
                        .frame(minHeight: K.padding * 20)
                        .scrollContentBackground(.hidden)
                        .background(Color(.systemGray6))
                        .cornerRadius(K.cornerRadius)
                        .padding(.vertical, K.padding * 0.5)
                    Text("Enter each ingredient on a new line.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Section(header: Text("Instructions / Steps").font(.headline)) {
                    TextEditor(text: $instructions)
                        .frame(minHeight: K.padding * 25)
                        .scrollContentBackground(.hidden)
                        .background(Color(.systemGray6))
                        .cornerRadius(K.cornerRadius)
                        .padding(.vertical, K.padding * 0.5)
                }
            }
            .navigationTitle("Add New Recipe")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveRecipe()
                    }
                    .disabled(recipeName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }

    // if this gets more complex, move to a ViewModel instead. Especially once you're doing sync / network calls.
    private func saveRecipe() {
        let trimmedName = recipeName.trimmingCharacters(in: .whitespacesAndNewlines)
         guard !trimmedName.isEmpty else { return }
         
         let newRecipe = Recipe(timestamp: Date(), title: trimmedName)
         
         modelContext.insert(newRecipe)
         
         do {
             try modelContext.save()
         } catch {
             // Handle save errors (present an alert instead?)
             print("Failed to save recipe: \(error)")
         }
         
         dismiss()
    }

}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
    }
}
