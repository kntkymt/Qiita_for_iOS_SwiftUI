//
//  ItemDetailView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI

struct ItemDetailView: View {

    // MARK: - Property

    @ObservedObject private var viewModel: ItemDetailViewModel

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
                    Button(systemImage: viewModel.isLiked ? .handThumbsupFill : .handThumbsup, action: {
                        viewModel.isLiked ? viewModel.disLike() : viewModel.like()
                    })
                    .frame(width: 44, height: 44)
                    .imageScale(.large)
                    .border(Color(UIColor(named: "brand")!), width: 1, cornerRadius: 22)
                    .foregroundColor(viewModel.isLiked ? Color.white : Color(UIColor(named: "brand")!))
                    .background(viewModel.isLiked ? Color(UIColor(named: "brand")!) : Color.clear)
                    .cornerRadius(22)

                    Button(systemImage: viewModel.isStocked ? .folderFill : .folder, action: {
                        viewModel.isStocked ? viewModel.unStock() : viewModel.stock()
                    })
                    .frame(width: 44, height: 44)
                    .imageScale(.large)
                    .border(Color(UIColor(named: "brand")!), width: 1, cornerRadius: 22)
                    .foregroundColor(viewModel.isStocked ? Color.white : Color(UIColor(named: "brand")!))
                    .background(viewModel.isStocked ? Color(UIColor(named: "brand")!) : Color.clear)
                    .cornerRadius(22)

                    Button(systemImage: .squareAndArrowUp, action: {

                    })
                    .frame(width: 44, height: 44)
                    .imageScale(.large)
                    .border(Color.systemGray, width: 1, cornerRadius: 22)
                    .cornerRadius(22)
                    .foregroundColor(.systemGray)
                }
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
