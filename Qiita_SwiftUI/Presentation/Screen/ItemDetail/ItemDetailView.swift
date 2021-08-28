//
//  ItemDetailView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI
import SwiftUIX

struct ItemDetailView: View {

    // MARK: - Property

    @ObservedObject private var viewModel: ItemDetailViewModel
    @State private var shareSheetPresented = false

    // MARK: - Initializer

    init(item: Item, likeRepository: LikeRepository, stockRepository: StockRepository) {
        viewModel = ItemDetailViewModel(item: item, likeRepository: likeRepository, stockRepository: stockRepository)
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            WebView(url: viewModel.item.url)
                .navigationTitle(viewModel.item.title)

            ZStack {
                Color.secondarySystemBackground

                HStack(spacing: 36) {
                    if viewModel.isLiked {
                        Button(systemImage: .handThumbsupFill, action: { viewModel.disLike() })
                            .frame(width: 44, height: 44)
                            .imageScale(.large)
                            .border(Color("brand"), width: 1, cornerRadius: 22)
                            .foregroundColor(Color.white)
                            .background(Color("brand"))
                            .cornerRadius(22)
                    } else {
                        Button(systemImage: .handThumbsup, action: { viewModel.like() })
                            .frame(width: 44, height: 44)
                            .imageScale(.large)
                            .border(Color("brand"), width: 1, cornerRadius: 22)
                            .foregroundColor(Color("brand"))
                            .background(Color.clear)
                            .cornerRadius(22)
                    }

                    if viewModel.isStocked {
                        Button(systemImage: .folderFill, action: { viewModel.unStock() })
                            .frame(width: 44, height: 44)
                            .imageScale(.large)
                            .border(Color("brand"), width: 1, cornerRadius: 22)
                            .foregroundColor(Color.white)
                            .background(Color("brand"))
                            .cornerRadius(22)
                    } else {
                        Button(systemImage: .folder, action: { viewModel.stock() })
                            .frame(width: 44, height: 44)
                            .imageScale(.large)
                            .border(Color("brand"), width: 1, cornerRadius: 22)
                            .foregroundColor(Color("brand"))
                            .background(Color.clear)
                            .cornerRadius(22)
                    }

                    Button(systemImage: .squareAndArrowUp, action: { shareSheetPresented.toggle() })
                        .frame(width: 44, height: 44)
                        .imageScale(.large)
                        .border(Color.systemGray, width: 1, cornerRadius: 22)
                        .cornerRadius(22)
                        .foregroundColor(.systemGray)
                }.sheet(isPresented: $shareSheetPresented, content: {
                    AppActivityView(activityItems: [viewModel.item.url])
                })
            }.frame(height: 60, alignment: .center)
        }.onAppear {
            viewModel.checkIsLiked()
            viewModel.checkIsStocked()
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: ItemStubService.items[0], likeRepository: LikeStubService(), stockRepository: StockStubService())
    }
}
