import SwiftUI

struct TraineeRow: View {
    @EnvironmentObject var trainee: Trainee
    var image: UIImage {
        imageFromString(trainee.picture)
    }
    var body: some View {
        HStack(spacing: 20) {
            if trainee.traineeID.lowercased() == "076eee0e-04bf-413a-8dc1-5a52ed8ee7b7" {
                Image("head")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(.rect(cornerRadius: 20, style: .continuous))
            } else if trainee.firstName == "Sarah" {
                Image("head1")
                    .resizable()
                    .frame(width: 80, height: 80)
            } else if trainee.firstName == "Michael" {
                Image("head2")
                    .resizable()
                    .frame(width: 80, height: 80)
            } else if trainee.firstName == "Emily" {
                Image("head3")
                    .resizable()
                    .frame(width: 80, height: 80)
            } else if trainee.lastName == "Brown" {
                Image("head4")
                    .resizable()
                    .frame(width: 80, height: 80)
            }
            
            else {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(.rect(cornerRadius: 20, style: .continuous))
            }
            
            VStack(alignment: .leading) {
                Text("\(trainee.firstName) \(trainee.lastName)")
                    .font(.system(size: 18, weight: .semibold, design: .serif))
                Text("ID: \(String(trainee.traineeID))")
                    .font(.system(size: 14, weight: .regular, design: .serif))
                Text("Email: \(trainee.emailAddress)")
                    .font(.system(size: 14, weight: .regular, design: .serif))
            }
        }
    }
}

