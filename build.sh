#!/bin/bash
set -e

# Crear estructura de directorios si no existe
mkdir -p source source/includes

# Crear archivo de ejemplo para la documentación principal si no existe
if [ ! -f source/index.html.md ]; then
  cat > source/index.html.md << 'EOL'
# API de Pedidos

## Introducción

Esta API permite gestionar pedidos en la plataforma de Marketplace. Proporciona endpoints para consultar, crear y actualizar información relacionada con los pedidos de los clientes.

## Autenticación

Todas las peticiones a la API deben incluir un token de autenticación válido en el encabezado HTTP:

```
Authorization: Bearer {token}
```

## Base URL

```
https://api.marketplace.com/v1
```

## Endpoints

### Obtener Pedidos

#### GET /orders

Retorna una lista de pedidos según los filtros proporcionados.

##### Parámetros de consulta

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| marketplace | string | Filtrar por marketplace (ej. "T1") |
| sellerID | string | Filtrar por ID del vendedor |
| startDate | string | Fecha inicial (formato: YYYY-MM-DD) |
| endDate | string | Fecha final (formato: YYYY-MM-DD) |
| status | string | Estado del pago (ej. "done") |
| limit | integer | Número máximo de resultados (por defecto: 20) |
| offset | integer | Número de resultados a omitir (por defecto: 0) |

##### Respuesta

```json
{
  "total": 42,
  "limit": 20,
  "offset": 0,
  "orders": [
    {
      "orderid": "990_127000128_TestDev1",
      "marketplace": "T1",
      "sellerID": "12028",
      "purchase_date": "2025-03-05 12:18:58",
      "authorization_date": "2025-03-05 12:18:58",
      "clientData": {
        "id": "angel.martinez@claroshop.com",
        "fullname": "Angel Martinez Lopez",
        "email": "angel.martinez@claroshop.com"
      },
      "paymentData": {
        "status": "done",
        "total": 1237
      }
    }
    // Más pedidos...
  ]
}
```

#### GET /orders/{orderid}

Retorna información detallada de un pedido específico.

##### Parámetros de ruta

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| orderid | string | ID único del pedido |

##### Respuesta

```json
{
  "authorization_date": "2025-03-05 12:18:58",
  "clientData": {
    "email": "angel.martinez@claroshop.com",
    "fullname": "Angel Martinez Lopez",
    "id": "angel.martinez@claroshop.com"
  },
  "marketplace": "T1",
  "orderid": "990_127000128_TestDev1",
  "paymentData": {
    "bank": "",
    "bankAffiliation": "BBVA",
    "commissions": {
      "gatewayFixed": 2.9,
      "gatewaySurcharge": 0,
      "gatewayVariable": 0,
      "t1paginas": 28.1
    },
    "paymentDueDate": "2025-03-05 12:18:58",
    "paymentInstallments": "MSI",
    "paymentNoInstallments": 1,
    "paymentReference": "72c1d3fe92074f47b27630bcfffc816f",
    "plan": "middle",
    "shippingCosts": 0,
    "status": "done",
    "subtotal": 1237,
    "total": 1237
  },
  "purchase_date": "2025-03-05 12:18:58",
  "sellerID": "12028",
  "shippingAddress": {
    "borough": "Miguel Hidalgo",
    "city": "Ciudad de Mexico",
    "notes": "Edificio Presa Falcón",
    "outdoorNumber": "245",
    "phoneNumber": "1234567890",
    "state": "Ciudad de Mexico",
    "street": "Lago Zúrich",
    "Suburb": "Ampliación Granada",
    "zipCode": "11529"
  },
  "orderedProductsList": [
    {
      "colocationId": "1000001",
      "idProduct": 6078,
      "sellerId": 12028,
      "name": "Camisa De Vestir Niño Rosa Coral Manga Larga 3582 2-18 Años",
      "sku": "I22v4ufp3989",
      "ImageLinkThumbnail": "http://img.ltwebstatic.com/images3_spmp/2024/01/04/f3/17043061112560de4bc5152f9d9d12deb18c6e4043_square.jpg",
      "salePrice": 329,
      "saleDiscount": 0,
      "totalSale": 329,
      "colocationStatus": {
        "id": "1",
        "name": "por enviar"
      },
      "deliveryType": "dropshipping",
      "productType": "physical",
      "tipo_envio": "manual"
    }
    // Más productos...
  ]
}
```

### Crear Pedido

#### POST /orders

Crea un nuevo pedido en el sistema.

##### Cuerpo de la solicitud

```json
{
  "marketplace": "T1",
  "sellerID": "12028",
  "clientData": {
    "email": "cliente@ejemplo.com",
    "fullname": "Nombre Completo",
    "id": "cliente@ejemplo.com"
  },
  "shippingAddress": {
    "street": "Nombre de la calle",
    "outdoorNumber": "123",
    "Suburb": "Nombre de la colonia",
    "borough": "Nombre de la delegación",
    "city": "Ciudad",
    "state": "Estado",
    "zipCode": "12345",
    "phoneNumber": "1234567890",
    "notes": "Notas adicionales"
  },
  "paymentData": {
    "bankAffiliation": "BBVA",
    "paymentInstallments": "MSI",
    "paymentNoInstallments": 1,
    "plan": "middle",
    "shippingCosts": 0,
    "subtotal": 1237,
    "total": 1237
  },
  "orderedProductsList": [
    {
      "idProduct": 6078,
      "sellerId": 12028,
      "name": "Camisa De Vestir Niño Rosa Coral Manga Larga 3582 2-18 Años",
      "sku": "I22v4ufp3989",
      "salePrice": 329,
      "saleDiscount": 0,
      "totalSale": 329,
      "deliveryType": "dropshipping",
      "productType": "physical",
      "tipo_envio": "manual"
    }
    // Más productos...
  ]
}
```

##### Respuesta

```json
{
  "success": true,
  "message": "Pedido creado correctamente",
  "orderid": "990_127000129_TestDev1",
  "purchase_date": "2025-03-12 15:30:45",
  "authorization_date": "2025-03-12 15:30:45"
}
```

### Actualizar Pedido

#### PATCH /orders/{orderid}

Actualiza información de un pedido existente.

##### Parámetros de ruta

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| orderid | string | ID único del pedido |

##### Cuerpo de la solicitud

El cuerpo debe contener solo los campos que se desean actualizar. Por ejemplo:

```json
{
  "paymentData": {
    "status": "cancelled",
    "paymentReference": "nuevo_reference_id"
  },
  "shippingAddress": {
    "phoneNumber": "9876543210"
  }
}
```

##### Respuesta

```json
{
  "success": true,
  "message": "Pedido actualizado correctamente",
  "orderid": "990_127000128_TestDev1",
  "modified_fields": ["paymentData.status", "paymentData.paymentReference", "shippingAddress.phoneNumber"]
}
```

#### PATCH /orders/{orderid}/products/{colocationId}

Actualiza información de un producto específico dentro de un pedido.

##### Parámetros de ruta

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| orderid | string | ID único del pedido |
| colocationId | string | ID de colocación del producto |

##### Cuerpo de la solicitud

```json
{
  "colocationStatus": {
    "id": "2",
    "name": "enviado",
    "reasonID": null,
    "reasonName": null
  },
  "deliveryTrackId": "TRACK123456",
  "deliveryCarrierId": "CARRIER001",
  "deliveryCarrierName": "DHL"
}
```

##### Respuesta

```json
{
  "success": true,
  "message": "Producto actualizado correctamente",
  "orderid": "990_127000128_TestDev1",
  "colocationId": "1000001",
  "modified_fields": ["colocationStatus", "deliveryTrackId", "deliveryCarrierId", "deliveryCarrierName"]
}
```

## Códigos de estado

| Código | Descripción |
|--------|-------------|
| 200 | Éxito |
| 201 | Recurso creado correctamente |
| 400 | Solicitud incorrecta |
| 401 | No autorizado |
| 403 | Prohibido |
| 404 | No encontrado |
| 422 | Entidad no procesable |
| 500 | Error interno del servidor |

## Errores

Los errores devuelven un objeto JSON con la siguiente estructura:

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Descripción del error"
  }
}
```

### Códigos de error comunes

| Código | Descripción |
|--------|-------------|
| INVALID_PARAMETERS | Parámetros de solicitud inválidos |
| ORDER_NOT_FOUND | Pedido no encontrado |
| PRODUCT_NOT_FOUND | Producto no encontrado en el pedido |
| UNAUTHORIZED_SELLER | Vendedor no autorizado para este pedido |
| INVALID_STATUS_TRANSITION | Transición de estado no permitida |
EOL
fi

# Crear archivo para documentar errores si no existe
if [ ! -f source/includes/_errors.md ]; then
  cat > source/includes/_errors.md << 'EOL'
# Errores

La API usa los siguientes códigos de error:

Error Code | Significado
---------- | -------
400 | Bad Request -- La petición es inválida
401 | Unauthorized -- Tu API key es errónea
403 | Forbidden -- El recurso está prohibido para ti
404 | Not Found -- El recurso especificado no pudo ser encontrado
405 | Method Not Allowed -- Método HTTP incorrecto
406 | Not Acceptable -- Has solicitado un formato no aceptable
429 | Too Many Requests -- Has excedido tus límites de API
500 | Internal Server Error -- Problemas con nuestro servidor
503 | Service Unavailable -- El servicio está temporalmente fuera de línea
EOL
fi

# Crear el Dockerfile si no existe
if [ ! -f Dockerfile ]; then
  cat > Dockerfile << 'EOL'
FROM ruby:2.7

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    git \
    zip

# Configurar directorio de trabajo
WORKDIR /usr/src/app

# Clonar Slate (usar una versión específica conocida por ser estable)
RUN git clone --branch v2.13.0 https://github.com/slatedocs/slate.git .


# Instalar las dependencias de Ruby
RUN bundle install

COPY ./source /usr/src/app/source

# Comando por defecto para compilar
CMD ["bundle", "exec", "middleman", "build", "--clean"]
EOL
fi

# Crear la función Lambda si no existe
if [ ! -f lambda_function.py ]; then
  cat > lambda_function.py << 'EOL'
import json
import base64
import mimetypes
import os

def get_content_type(file_path):
    content_type, _ = mimetypes.guess_type(file_path)
    if content_type is None:
        # Default to text/html for unknown types
        return 'text/html'
    return content_type

def lambda_handler(event, context):
    path = event.get('path', '')
    
    # Maneja la ruta base mostrando index.html
    if path == '/' or path == '':
        path = '/index.html'
    
    # Elimina la barra inicial para leer desde el directorio local
    file_path = path[1:] if path.startswith('/') else path
    
    try:
        # Intenta abrir el archivo solicitado
        with open(file_path, 'rb') as file:
            content = file.read()
        
        # Determina el content type basado en la extensión del archivo
        content_type = get_content_type(file_path)
        
        # Codifica el contenido en base64 para imágenes y otros archivos binarios
        is_binary = not (content_type.startswith('text/') or 
                         content_type == 'application/json' or 
                         content_type == 'application/javascript')
        
        if is_binary:
            content = base64.b64encode(content).decode('utf-8')
            return {
                'statusCode': 200,
                'headers': {'Content-Type': content_type},
                'body': content,
                'isBase64Encoded': True
            }
        else:
            return {
                'statusCode': 200,
                'headers': {'Content-Type': content_type},
                'body': content.decode('utf-8'),
                'isBase64Encoded': False
            }
            
    except FileNotFoundError:
        return {
            'statusCode': 404,
            'body': json.dumps({'error': 'File not found'}),
            'headers': {'Content-Type': 'application/json'}
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}),
            'headers': {'Content-Type': 'application/json'}
        }
EOL
fi
set -e
echo "Construyendo la imagen Docker..."
docker builder prune -f
docker build --no-cache -t slate-docs .
docker rm -f slate-temp || true

# Eliminar el directorio build en la máquina local
rm -rf build

# Creamos el directorio build localmente
mkdir -p build

echo "Ejecutando el contenedor para compilar la documentación..."


docker run --name slate-temp slate-docs

# Copiamos los archivos del contenedor al host
docker cp slate-temp:/usr/src/app/build/. ./build/


# Limpiamos el contenedor temporal
docker rm slate-temp

# Verificar si la compilación fue exitosa
if [ -d "build" ] && [ "$(ls -A build)" ]; then
  echo "La documentación se compiló exitosamente en el directorio 'build'"
  
  # Copiar la función Lambda a la carpeta build
  cp lambda_function.py build/
  
  # Crear el archivo ZIP para Lambda
  echo "Creando archivo ZIP para AWS Lambda..."
  cd build
  zip -r ../lambda-slate-docs.zip *
  cd ..
  
  echo "¡Todo listo! El archivo lambda-slate-docs.zip está listo para ser subido a AWS Lambda."
  echo "Puedes subirlo usando la consola web de AWS o con este comando:"
  echo "aws lambda update-function-code --function-name TU_FUNCION_LAMBDA --zip-file fileb://lambda-slate-docs.zip"
else
  echo "Error: La compilación falló o no generó archivos."
  echo "Revisa los mensajes de error de Docker para más detalles."
fi