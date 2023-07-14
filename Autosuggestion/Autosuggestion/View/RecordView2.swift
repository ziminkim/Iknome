//
//  RecordView2.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/13.
//

import SwiftUI
import AVFoundation
import AVKit


struct RecordView2: View {
    
    @State var record = false // record statue, @state for update view
    @State var session : AVAudioSession! // 값이 무조건 있다. 옵셔널이지?
    @State var alert = false
    
    var body: some View {
        
        NavigationView{
            
            Button {
                self.record.toggle()
            } label: {
                ZStack {
                    Circle()
                        .fill(.red) // fill이 frame 뒤에 오니까 에러나네?
                        .frame(width: 70, height: 70)//width가 앞에 와야한대
                    
                    if self.record == false { //show only not recording
                        Circle()
                            .stroke(.white, lineWidth: 6)
                            .frame(width: 85, height: 85)
                    }
                    
                }.padding(.vertical, 25) //위 아래로 25 padding
            }
            .navigationBarTitle("Record View")

        }
        .alert(isPresented: self.$alert, content: {
            Alert(title: Text("Error"), message: Text("오디오 접근 권한이 없습니다")
            )
        })
        //permission
        .onAppear { //view가 화면에 나타날 때 호출됨
            
            do{ //옵셔널에 대한 에러 처리를 위해 하는 건가?
                //앱 오디오 세션과 OS간 상호작용을 위해 AVAudioSession 객체를 사용함
                //하나로 공유되는 싱글톤 인스턴스 생성
                self.session = AVAudioSession.sharedInstance()
                //어떤 모드로 오디오를 사용할 지 정의
                try self.session.setCategory(.playAndRecord)
                
                //아래 함수 자체가 공백이 아닐 경우 요청을 다시 안하나? true 일 때 그렇다는데
                //계속 false가 호출되고 있음
                //실제 테스트 해보라는데 유선연결이 안되는 상황
                //
                self.session.requestRecordPermission() { (result) in // boolean으로 받아옴
                    if !result {
                        //권한이 거부되었을 경우 경고창 실행
                        
                        self.alert.toggle()
                    } else {
                        //권한이 있으면 getAudios 메소드 실행
                            self.getAudios()
                    }
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        
    }
    
    func getAudios(){
        print("test")
    }
    
    
    
    
}

struct RecordView2_Previews: PreviewProvider {
    static var previews: some View {
        RecordView2()
            .preferredColorScheme(.dark)
    }
}
