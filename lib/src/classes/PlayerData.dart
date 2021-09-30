class PlayerData {
  String nombre;
  String fecha;
  int dolor;
  int fatiga;
  int intensidad;

  PlayerData(this.nombre, this.fecha, this.dolor, this.fatiga, this.intensidad);

  factory PlayerData.fromJson(dynamic json) {
    return PlayerData(
      json['nombre'] as String,
      json['fecha'] as String,
      json['dolor'] as int,
      json['fatiga'] as int,
      json['intensidad'] as int,
    );
  }

  Map toJson() => {
        'nombre': nombre,
        'fecha': fecha,
        'dolor': dolor,
        'fatiga': fatiga,
        'intensidad': intensidad
      };
}
