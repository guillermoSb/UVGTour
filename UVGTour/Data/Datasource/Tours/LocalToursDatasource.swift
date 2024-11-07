//
//  LocalToursDatasource.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/18/24.
//

import Foundation

// Yellow - 4056668d19dfe5fab47c9e83c82a982b
// Brown - 8cc2e0a06f1666b863df2ea773e7ad02
// White - fd7d34c180ba4e9610a4439cd205712c
/// Datasource with tours stored locally.
struct LocalToursDatasource: ToursRepository {
    
    public static let tours: [Tour] = [
        Tour(
            id: "1",
            name: "CIT".hardcoded,
            description: "Un tour en todas las instalaciones del CIT".hardcoded,
            duration: .seconds(60 * 30),
            stops: [
                Stop(
                    name: "Plaza",
                    description: """
                    La Plaza de la Universidad del Valle de Guatemala (UVG) es el corazón vibrante del campus, un espacio amplio y abierto que simboliza la conexión entre la tradición académica y el dinamismo estudiantil. Rodeada de jardines bien cuidados y edificios emblemáticos, la plaza es un punto de encuentro natural para estudiantes, profesores y visitantes. Aquí, bajo la sombra de árboles frondosos y con el sonido suave del agua de las fuentes cercanas, se llevan a cabo diversas actividades que van desde eventos culturales y ferias estudiantiles hasta ceremonias institucionales. Con su atmósfera relajada y su ubicación central, la Plaza de la UVG no solo es un lugar de tránsito, sino también un espacio para la reflexión, la convivencia y el disfrute del ambiente universitario.
                    """,
                    emoji: "🐲",
                    sensorId: "4056668d19dfe5fab47c9e83c82a982b", nextStopDirection: -.pi/4, imageName: nil // osete
                    
                ),
                Stop(name: "waypoint01", description: "Just a waypoint", emoji: "📚", sensorId: "8cc2e0a06f1666b863df2ea773e7ad02", nextStopDirection: .pi/4, imageName: nil, isWaypoint: true), // norte,
                Stop(name: "Biblioteca", description: "Biblioteca de la UVG.", emoji: "📚", sensorId: "fd7d34c180ba4e9610a4439cd205712c", nextStopDirection: .pi/4, imageName: nil, interestPoints: []), // norte
                
//                Stop(name: "Canchas", description: "Canchas deportivas de la UVG", emoji: "🎾", sensorId: "fd7d34c180ba4e9610a4439cd205712c", nextStopDirection: .pi, imageName: nil), // sur
            ]),
        Tour(
            id: "2",
            name: "Biblioteca".hardcoded,
            description: "un tour en la biblioteca del CIT".hardcoded,
            duration: .seconds(60 * 30),
            stops: [
                Stop(
                    name: "Sillones de lectura",
                    description: """
                    El espacio de sillones de lectura en la biblioteca del Centro de Innovación y Tecnología (CIT) de la Universidad del Valle de Guatemala ofrece un ambiente acogedor y moderno. Con sillones cómodos dispuestos en áreas iluminadas por luz natural, este espacio está diseñado para la concentración y el estudio individual. Las amplias ventanas permiten vistas relajantes hacia los jardines exteriores, mientras que las estanterías cercanas ofrecen acceso rápido a una gran variedad de libros y recursos académicos. Es un lugar ideal para desconectarse del bullicio y sumergirse en la lectura o la investigación.
                    """,
                    emoji: "🛋️",
                    sensorId: "4056668d19dfe5fab47c9e83c82a982b", nextStopDirection: .pi/6, // osete
                    imageName: "sillonesBiblio"
                    
                ),
                Stop(name: "Salon Silencioso", description: "El salón silencioso en la biblioteca del CIT en la Universidad del Valle de Guatemala está diseñado para quienes buscan un entorno de estudio completamente libre de distracciones. Con un ambiente minimalista y luz tenue, el espacio está equipado con mesas individuales y sillas ergonómicas, donde se fomenta la concentración profunda y el trabajo en silencio absoluto. Los dispositivos electrónicos deben ser usados en modo silencioso, y el respeto por el entorno tranquilo es primordial. Es el lugar perfecto para realizar lecturas intensas, escribir o preparar exámenes en un entorno de total calma.", emoji: "🤫", sensorId: "8cc2e0a06f1666b863df2ea773e7ad02", nextStopDirection: 0,
                    imageName: "silenciosoBiblio"), // norte
                
                Stop(name: "Comedor", description: "El comedor en la biblioteca del CIT de la Universidad del Valle de Guatemala es un espacio amplio y cómodo, ideal para disfrutar de un descanso entre sesiones de estudio. Con mesas y sillas modernas, ofrece un ambiente relajado donde los estudiantes pueden comer, socializar o simplemente desconectar. Equipado con microondas y máquinas expendedoras, el comedor facilita el acceso rápido a refrigerios.", emoji: "🍲", sensorId: "fd7d34c180ba4e9610a4439cd205712c", nextStopDirection: .pi, imageName: nil), // sur
            ]),
        
        Tour(id: "3", name: "Biblioteca Waypoint", description: "Demo de waypoints en biblioteca", duration: .seconds(60 * 5), stops: [
            Stop(
                name: "Salon N",
                description: """
                El Salón N permite a estudiantes discutir y estudiar.
                """,
                emoji: "📚",
                sensorId: "4056668d19dfe5fab47c9e83c82a982b", nextStopDirection: .pi/4 + .pi/12, // osete
                imageName: "salonN"
            ),
            Stop(
                name: "Escritorio",
                description: """
                """,
                emoji: "",
                sensorId: "8cc2e0a06f1666b863df2ea773e7ad02", nextStopDirection: .pi/2 + .pi/4 + .pi/12, // osete
                imageName: nil,
                interestPoints: [
                    InterestPoint(name: "Salon J", distance: 5)
                ],
                isWaypoint: true

            ),
            Stop(name: "Salon Silencioso", description: "El salón silencioso en la biblioteca del CIT en la Universidad del Valle de Guatemala está diseñado para quienes buscan un entorno de estudio completamente libre de distracciones. Con un ambiente minimalista y luz tenue, el espacio está equipado con mesas individuales y sillas ergonómicas, donde se fomenta la concentración profunda y el trabajo en silencio absoluto. Los dispositivos electrónicos deben ser usados en modo silencioso, y el respeto por el entorno tranquilo es primordial. Es el lugar perfecto para realizar lecturas intensas, escribir o preparar exámenes en un entorno de total calma.", emoji: "🤫", sensorId: "fd7d34c180ba4e9610a4439cd205712c", nextStopDirection: 0,
                imageName: "silenciosoBiblio"),
        
        ]),
        
        Tour(id: "4", name: "Cafeteria", description: "Demo en la cafeteria", duration: .seconds(60 * 5), stops: [
            Stop(
                name: "Mixtas Frankfurt",
                description: """
                Restaurante de Mixtas.
                """,
                emoji: "🌭",
                sensorId: "4056668d19dfe5fab47c9e83c82a982b", nextStopDirection: -.pi/2, // osete
                imageName: "salonN"
            ),
            Stop(
                name: "Escritorio",
                description: """
                """,
                emoji: "",
                sensorId: "8cc2e0a06f1666b863df2ea773e7ad02", nextStopDirection: .pi, // osete
                imageName: nil,
                interestPoints: [
                    InterestPoint(name: "Salon J", distance: 2)
                ],
                isWaypoint: true

            ),
            Stop(name: "Cafe Gitane", description: "Lugar relajante para tomar un cafe", emoji: "☕️", sensorId: "fd7d34c180ba4e9610a4439cd205712c", nextStopDirection: 0,
                imageName: "silenciosoBiblio", interestPoints: [
                    InterestPoint(name: "Sillas", distance: 2)
                ]),
        
        ]),
        Tour(id: "5", name: "Lab Realidad Virtual", description: "Demo en el lab", duration: .seconds(60 * 5), stops: [
            Stop(
                name: "Casilleros",
                description: """
                Puedes guardar aquí tus pertenencias.
                """,
                emoji: "🎒",
                sensorId: "4056668d19dfe5fab47c9e83c82a982b", nextStopDirection: .pi/2,
                imageName: "casilleros"
            ),
            Stop(
                name: "",
                description: """
                """,
                emoji: "",
                sensorId: "8cc2e0a06f1666b863df2ea773e7ad02", nextStopDirection: .pi + .pi/6,
                imageName: nil,
                interestPoints: [
                    InterestPoint(name: "Virtualizer 2", distance: 2)
                ],
                isWaypoint: true

            ),
            Stop(name: "Pizarrones", description: "Describe tus mejores ideas", emoji: "💡", sensorId: "fd7d34c180ba4e9610a4439cd205712c", nextStopDirection: 0,
                imageName: "pizarrones"),
        
        ])
        
    ]
    
    func fetchAllTours() async throws -> [Tour] {
        return LocalToursDatasource.tours
    }
    
}
