//
//  RecordView2.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/13.
//

import SwiftUI
import AVFoundation
import AVKit


struct RecordView: View {
    
    @State var record = false // record statue, @state for update view
    @State var session : AVAudioSession! // 값이 무조건 있다. 옵셔널이지?
    @State var alert = false
    @State var recorder : AVAudioRecorder!
    @State var audios : [URL] = [] //빈 배열인데 url을 넣을거야
    
    var body: some View {
        
        NavigationView{
            
            
            VStack {// button이랑 세로로 쌓을거야
                
                List(self.audios, id: \.self){ i in
                    //파일명 표시
                    Text(i.relativeString)
                }
                
                Button {
                    //button을 눌렀을 때, 녹음이 시작되어야함
                    
                    do{ //옵셔널 변수 recorder의 에러 캐치를 위해서
                        if self.record{
                            //녹음 중일 때 버튼을 누르면
                            self.recorder.stop() //녹음을 멈추고
                            self.record.toggle() //녹음 상태를 바꾸고
                            self.getAudios() //녹음을 가져와야함
                            return //그리고 아웃
                        }
                        
                        //녹음 중이 아닐 때 버튼을 누르면 녹음
                        
                        //저장할 디렉토리 지정
                        //filemanager 인스턴스 생성, 경로 지정
                        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        
                        //지정한 경로에 파일 추가
                        let filename = url.appendingPathComponent("myrcd\(self.audios.count + 1).m4a")
                        
                        //녹음 품질에 대한 세팅 자세히 알지 말자
                        let setting = [
                            AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey: 12000,
                            AVNumberOfChannelsKey: 1,
                            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                        ]
                        
                        //레코더 옵셔널 변수에 대한 지정
                        self.recorder = try AVAudioRecorder(url: filename, settings: setting)
                        //녹음 시작
                        self.recorder.record()
                        //녹음 상태 변경
                        self.record.toggle()
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    
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
                
                //아래 함수 자체가 공백이 아닐 경우 요청을 다시 안하나? 그렇다는데
                self.session.requestRecordPermission() { (result) in // boolean으로 받아옴
                    if !result {
                        //권한이 거부되었을 경우 경고창 실행
                        self.alert.toggle()
                    } else {
                        //권한이 있으면 녹음 파일 가져오기
                            self.getAudios()
                    }
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        
    }
    
    func getAudios(){
        //저장된 녹음 파일 가져오기
        do{
            
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            //해당 디렉토리를 서치해서 그 안에 포함된 url들을 가져온다
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            //빈 배열에다 넣어야함
            self.audios.removeAll()
            
            for i in result {
                self.audios.append(i)
            }
            
            
        } catch {
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    
    
}

struct RecordView2_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
            .preferredColorScheme(.dark)
    }
}
