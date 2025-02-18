//
//  DetailClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//
import SwiftUI

struct ClientDetailsView: View {

    // MARK: - Properties
    var client: Client
    private var viewModel: ClientListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showSuccess = false
    @State private var showConfirmation = false

    // MARK: - Init
    init(client: Client, viewModel: ClientListViewModel) {
        self.client = client
        self.viewModel = viewModel
    }

    // MARK: - View
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.orange)
                .padding(50)
            Spacer()
            Text(client.name)
                .font(.title)
                .padding()
            Text(client.email)
                .font(.title3)
            Text(viewModel.dateToStringFormatter(for: client))
                .font(.title3)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Supprimer") {
                    showConfirmation = true
                }
                .foregroundStyle(.red)
                .bold()
            }
        }
        .alert("Confirmer la suppression", isPresented: $showConfirmation) {
            Button("Annuler", role: .cancel) { }
            Button("Supprimer", role: .destructive) {
                viewModel.deleteClient(name: client.name, email: client.email)
                showSuccess = true
            }
        } message: {
            Text("Voulez-vous vraiment supprimer \(client.name) ? Cette action est irréversible.")
        }
        .alert("Succès", isPresented: $showSuccess) {
            Button("OK") {
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Le client \(client.name) a été supprimé avec succès !")
        }
    }
}

#Preview {
    ClientDetailsView(client: Client(name: "Tata",
                                     email: "tata@email",
                                     creationDateString: "20:32 Wed, 30 Oct 2019"),
                      viewModel: ClientListViewModel())
}
