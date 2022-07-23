class Toros {
  final int id;
  final int id_usuario;
  final String nombre;
  final String descripcion;
  final String raza;
  final String num_arete;
  final String url_img;
  final int estado;
  final String fecha_llegada;
  final int edad;//id, id_usuario, nombre, descripcion, raza, num_arete, url_img, estado, fecha_llegada, id_vaca, edad

  Toros({required this.id, required this.id_usuario, required this.nombre, required this.descripcion, required this.raza, 
  required this.num_arete, required this.url_img, required this.estado, required this.fecha_llegada, required this.edad});
}