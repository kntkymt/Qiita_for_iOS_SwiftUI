//
//  SettingView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import SwiftUI
import Common

public struct SettingView: View {

    // MARK: - Property

    @EnvironmentObject var authState: AuthState
    
    @Binding private var isPresenting: Bool
    @State private var showingAlert = false

    @StateObject private var viewModel: SettingViewModel

    // MARK: - Initializer

    init(isPresenting: Binding<Bool>, viewModel: SettingViewModel) {
        self._isPresenting = isPresenting
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body

    public var body: some View {
        NavigationView {
            Form {
                Section {
                    Link("iPhoneの設定を開く", destination: URL(string: UIApplication.openSettingsURLString)!)
                        .foregroundColor(.primary)
                }
                Section {
                    NavigationLink("開発者情報", destination: WebView(url: URL(string: AppConstant.Link.developer)!))
                    NavigationLink("リポジトリ", destination: WebView(url: URL(string: AppConstant.Link.repository)!))
                }
                Section {
                    HStack {
                        Spacer()
                        Button("ログアウト") {
                            showingAlert.toggle()
                        }
                        .foregroundColor(.red)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("ログアウト"),
                                  message: Text("本当によろしいですか?"),
                                  primaryButton: .cancel(Text("キャンセル")),
                                  secondaryButton: .destructive(Text("ログアウト")) {

                                Task {
                                    await viewModel.logout() {
                                        isPresenting = false

                                        // authStateが変わるとログイン画面に戻るが
                                        // すぐに戻すとmodal元のProfileViewがなくなり
                                        // modalをdissmissできなくなるので遅らせる
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            authState.isSignedin = false
                                        }
                                    }
                                }
                            })
                        }
                        Spacer()
                    }
                }
            }.navigationBarTitle("設定", displayMode: .inline)
        }
    }
}

//struct SettingView_Previews: PreviewProvider {
//
//    @State static var isPresenting: Bool = true
//
//    static var previews: some View {
//        SettingView(isPresenting: $isPresenting, viewModel: SettingViewModel(authRepository: AuthStubService()))
//            .environmentObject(AuthState(authRepository: AuthStubService()))
//    }
//}
