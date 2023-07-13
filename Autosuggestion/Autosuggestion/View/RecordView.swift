//
//  RecordView.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/11.
//

import SwiftUI
import AVKit
import AVFoundation

struct RecordView: View {
    @State var record = false //값이 변경되면 뷰가 업데이트 된다
    @State var session : AVAudioSession! // 옵셔널 : 값이 무조건 있다~
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    @State var audios : [URL] = []
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                List(self.audios, id: \.self) { i in
                    //printing only file name
                    Text(i.relativeString)
                }
                
                Button(action: {
                    do{
                        if self.record {
                            //녹음 중에는 멈추고 저장해야지
                            self.recorder.stop()
                            self.record.toggle()
                            self.getAudios()
                            return
                        }
                        
                        //저장될 디렉토리
                        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        let fileName = url.appendingPathComponent("myRcd\(self.audios.count + 1).m4a")
                        
                        let settings = [
                            AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey : 12000,
                            AVNumberOfChannelsKey : 1,
                            AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
                        ]
                        
                        //녹음
                        self.recorder = try AVAudioRecorder(url: fileName, settings: settings)
                        
                        self.recorder.record()
                        self.record.toggle()
                    } catch {
                        print(error.localizedDescription)
                    }
                }){
                    
                        ZStack{
                        Circle()
                            .fill(.red)
                            .frame(width: 70, height: 70)
                        
                        if self.record{
                            Circle()
                                .stroke(.white, lineWidth: 6)
                                .frame(width: 85, height: 85)
                        }
                    }
                    
                }
                .padding(.vertical, 25)
            }
            .navigationBarTitle("Record View")
        }//접근요청 창 떴을 때, 거부 했더니 그 뒤로 앱 실행하면 에러 메시지만 뜸
        .alert(isPresented: self.$alert, content: {
            Alert(title: Text("Error"), message: Text("Enable Access"))
        })
        .onAppear{
            do{
                //오디오 세션을 가져와서 어떤 종류를 할건지 설정해줌
                self.session = AVAudioSession.sharedInstance()
                //error 처리하려면 try
                try self.session.setCategory(.playAndRecord)
                //오디오 접근 권한 요청하고 결과 받아옴
                self.session.requestRecordPermission{ (accepted) in
                    if !accepted {
                        self.alert.toggle()
                    } else {
                        //permission이 있다는 것은 모든 데이터를 가져오란 거니까
                        self.getAudios()
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func getAudios() {
        do{
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            //document directory에서 모든 데이터를 가져온다
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            //update means remove all
            self.audios.removeAll()
            
            for i in result {
                self.audios.append(i)
            }
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
            .preferredColorScheme(.dark)
    }
    
}
