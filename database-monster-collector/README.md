# Base de Datos (MongoDB) - Monster Collector

Esta carpeta incluye el contenido de la base de datos del juego monster-collector

## 🗄️ Colecciones

### `users`
Guarda los datos de los jugadores.
* `username` (String, obligatorio): Nombre del usuario.
* `level` (Número, obligatorio): Nivel del jugador (1 a 100).
* `coins` (Número, obligatorio): Monedas disponibles.

### `monsters`
Guarda los monstruos obtenidos.
* `name` (String, obligatorio): Nombre de la criatura.
* `level` (Número, obligatorio): Nivel (1 a 100).
* `owner` (ObjectId, obligatorio): ID del jugador dueño (`users._id`).


## 🔗 Relación
* **1 a Muchos:** Un usuario puede tener varios monstruos. La relación se define mediante el campo `owner` en la colección `monsters`.