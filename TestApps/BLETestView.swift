import Foundation
import CoreBluetooth
import SwiftUI
internal import Combine
import CoreLocation

struct BLETestView: View {
    
    //@StateObject private var ble: BLE = BLE()
    @StateObject var recvData = BLE.shared
    
    //@State var sta: String = ""
    @State var fin: String = ""
    @State var r: Bool = false
    @State var coordinates: (lat: Double, lon: Double) = (0, 0)
    @State var tokens: Set<AnyCancellable> = []
    
    var body: some View {
        VStack{
            Button("Initiate meditions") {
                recvData.sign = "Start"
                if r == false {
                    recvData.Conn()
                    recvData.TimerToggle()
                }
                r = true
                //sta = "\(recvData.centralManager.state)"
            }
            Text(fin).padding(10)
            //Text("\(coordinates.lat)")
            //Text("\(coordinates.lon)")
            //Text(sta)
            
            Button("Stop meditions") {
                
                recvData.sign = "Stop"
                fin = "- -"
                r = false
                recvData.TimerToggle()
            }
            Button("Reset Bluetooth") {
                recvData.sign = "Start"
                fin = "Resetting..."
                r = false
                recvData.restart()
                fin = "Wait and press initiate"
            }
        }.onAppear {
            observe()
            recvData.requestLocationUpdates()
        }
    }
    
    func formattedTime() -> String{
        var date = Date()
        var calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        //var datf0 = String("\(dateNow)").split(separator: " ")[0]
        //var datf1 = String("\(dateNow)").split(separator: " ")[1]
        //return "\(datf0) \(datf1)"
        return "\(components.year!)-\(components.month!)-\(components.day!) \(components.hour!):\(components.minute!):\(components.second!)"
        }

    func observe() {
        recvData.locationPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
            } receiveValue: { coor in
                self.coordinates = (coor.latitude, coor.longitude)
            }
            .store(in: &tokens)
        
        recvData.BLEPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
            } receiveValue: { FIN in
                var dt = formattedTime()
                var lat = "\(self.coordinates.lat)"
                var lon = "\(self.coordinates.lon)"
                var todo = "\(dt),\(lat),\(lon),\(FIN)\n"
                self.fin = todo
            }
            .store(in: &tokens)
    }
}
