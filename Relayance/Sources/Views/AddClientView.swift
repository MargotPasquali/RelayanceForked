//
//  AjoutClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//
import SwiftUI

struct AddClientView: View {

    // MARK: - Properties

    var viewModel: ClientListViewModel
    @Binding var dismissModal: Bool
    @State var nom: String = ""
    @State var email: String = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showSuccess = false
    @State private var successMessage = ""

    // MARK: - View

    var body: some View {
        VStack {
            Text("Ajouter un nouveau client")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            TextField("Nom", text: $nom)
                .font(.title2)
            TextField("Email", text: $email)
                .font(.title2)
            Button("Ajouter") {
                do {
                    let newClient = try viewModel.createNewClient(name: nom, email: email)
                    successMessage = "Le client \(newClient.name) a été ajouté avec succès !"
                    showSuccess = true
                } catch let error as ClientListViewModel.ClientListViewModelError {
                    errorMessage = error.localizedDescription
                    showError = true
                } catch {
                    errorMessage = "Une erreur inconnue est survenue."
                    showError = true
                }
            }
            .padding(.horizontal, 50)
            .padding(.vertical)
            .font(.title2)
            .bold()
            .background(RoundedRectangle(cornerRadius: 10).fill(.orange))
            .foregroundStyle(.white)
            .padding(.top, 50)
            Spacer()
        }
        .padding()
        .alert("Erreur", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .alert("Succès", isPresented: $showSuccess) {
            Button("OK") {
                dismissModal.toggle()
            }
        } message: {
            Text(successMessage)
        }
    }
}

#Preview {
    AddClientView(viewModel: ClientListViewModel(), dismissModal: .constant(false))
}
