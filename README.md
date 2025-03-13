# Slate Docker Test

Este proyecto permite convertir un archivo `openapi.json` a formato Markdown utilizando `widdershins`, y luego generar documentación en HTML mediante `Slate` dentro de un contenedor Docker.

## Prerrequisitos

Asegúrate de tener instalados los siguientes componentes antes de continuar:

- [Node.js](https://nodejs.org/) y [npm](https://www.npmjs.com/)
- [Docker](https://www.docker.com/)

## Pasos para generar la documentación

### 1. Convertir OpenAPI a Markdown

Ejecuta el siguiente comando para convertir un archivo `openapi.json` a `openapi.md`:

```sh
npx widdershins openapi.json -o source/index.html.md
```

### 2. Asignar permisos de ejecución al script `build.sh`

Si es la primera vez que ejecutas el script, otórgale permisos de ejecución:

```sh
chmod +x build.sh
```

### 3. Ejecutar `build.sh`

Ejecuta el siguiente comando para construir la documentación:

```sh
./build.sh
```

Este script realizará las siguientes acciones:

1. Creará la estructura de directorios necesaria.
2. Generará los archivos de documentación en formato Markdown si no existen.
3. Construirá una imagen Docker con `Slate`.
4. Ejecutará un contenedor temporal para compilar la documentación.
5. Extraerá los archivos generados y los empaquetará en un ZIP listo para AWS Lambda.

### 4. Subir la documentación a AWS Lambda (Opcional)

Si deseas desplegar la documentación en AWS Lambda, puedes hacerlo con el siguiente comando:

```sh
aws lambda update-function-code --function-name TU_FUNCION_LAMBDA --zip-file fileb://lambda-slate-docs.zip
```

## Notas

- Asegúrate de que el archivo `openapi.json` está correctamente formateado antes de ejecutar `widdershins`.
- Si `build.sh` falla por problemas de formato, conviértelo a formato Unix con:

  ```sh
  sed -i 's/\r$//' build.sh
  ```

- Si experimentas problemas con Docker, verifica que el servicio está corriendo ejecutando:

  ```sh
  docker info
  ```

---

¡Listo! Ahora puedes generar y desplegar documentación de manera rápida y eficiente. 🚀