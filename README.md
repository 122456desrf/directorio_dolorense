# directorio_dolores

# Directorio Dolorense: consumo de API local con TDD


## Ronda 1: La API (la cocina)

Servidor encendido:

![Servidor encendido](assets/R1_01_servidor_encendido.png)


## Ronda 2: Modelo Negocio (TDD)

Rojo: la prueba falla porque `negocio.dart` no existe.

![Rojo Negocio](assets/R2_01_rojo_negocio_test.png)

Verde: se crea el modelo y las 4 pruebas pasan.

![Verde Negocio](assets/R2_02_verde_negocio_test.png)

Estructura de la capa de dominio:

![Estructura dominio](assets/R2_03_estructura_dominio.png)

---

## Ronda 3: Cliente HTTP con MockClient (TDD)

Rojo: la prueba de `listar` falla porque `negocios_api.dart` no existe.

![Rojo API](assets/R3_01_rojo_api_test.png)

Verde: `listar` funciona.

![Verde API](assets/R3_02_verde_api_test.png)

Casos de falla (500, sin red, timeout y JSON roto):

![Casos de falla](assets/R3_03_verde_casos_falla.png)

Búsqueda, crear y eliminar:

![Crear, buscar y eliminar](assets/R3_04_verde_crear_buscar_eliminar.png)

Reto: prueba de `actualizar()` con PUT:

![Reto PUT](assets/R3_05_verde_reto_put.png)

---

## Ronda 4 en adelante

(Se completa en los siguientes pasos.)
