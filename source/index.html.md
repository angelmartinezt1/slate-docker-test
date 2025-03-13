---
title: API de Gestión de Órdenes

language_tabs: # must be one of https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers
  - shell: cURL
  - javascript: Node.js
  - python: Python

toc_footers:
  - <a href='#'>Registrarse para obtener un API Key</a>
  - <a href='https://github.com/slatedocs/slate'>Documentación generada con Slate</a>

includes:
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Documentación para la API de Gestión de Órdenes
---

# Introducción

Bienvenido a la API de Gestión de Órdenes. Esta API te permite gestionar todos los aspectos de los pedidos en nuestra plataforma, incluyendo la consulta, creación y actualización de órdenes.

La API está organizada en torno a principios REST. Todos los endpoints aceptan y devuelven datos JSON, utilizan códigos de respuesta HTTP estándar y requieren autenticación mediante token.

<aside class="notice">
Para utilizar esta API, necesitarás una clave de API (<code>API_KEY</code>). Contacta con nuestro equipo de soporte para obtener tus credenciales.
</aside>

# Autenticación

> Para autorizar, utiliza este código:

```shell
# Con cURL, pasa el header de autorización
curl "https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management"
  -H "Authorization: Bearer API_KEY"
```

```javascript
// En Node.js, incluye el token en el header de autorización
const axios = require('axios');

const api = axios.create({
  baseURL: 'https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management',
  headers: {
    'Authorization': `Bearer ${API_KEY}`,
    'Content-Type': 'application/json'
  }
});
```

```python
import requests

headers = {
    'Authorization': f'Bearer {API_KEY}',
    'Content-Type': 'application/json'
}

response = requests.get('https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management', headers=headers)
```

Nuestra API utiliza tokens de API para autenticar las solicitudes. Debes incluir tu token API en el header `Authorization` en todas tus solicitudes.

<aside class="warning">
Nunca compartas tu API key en repositorios públicos o en código cliente.
</aside>

# Órdenes

## Obtener un listado de órdenes

```shell
curl "https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management?email=angel.martinez@claroshop.com&marketplace=T1" \
  -H "Authorization: Bearer API_KEY"
```

```javascript
const axios = require('axios');

const api = axios.create({
  baseURL: 'https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management',
  headers: {
    'Authorization': `Bearer ${API_KEY}`,
    'Content-Type': 'application/json'
  }
});

async function getOrders() {
  try {
    const params = {
      email: 'angel.martinez@claroshop.com',
      marketplace: 'T1',
      startDate: '2025-01-01',
      endDate: '2025-03-12'
    };
    
    const response = await api.get('/orders', { params });
    console.log(response.data);
    return response.data;
  } catch (error) {
    console.error('Error al obtener órdenes:', error);
  }
}

getOrders();
```

```python
import requests
from datetime import datetime

headers = {
    'Authorization': f'Bearer {API_KEY}',
    'Content-Type': 'application/json'
}

params = {
    'email': 'angel.martinez@claroshop.com',
    'marketplace': 'T1',
    'startDate': '2025-01-01',
    'endDate': '2025-03-12'
}

response = requests.get('https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management', headers=headers, params=params)

if response.status_code == 200:
    orders = response.json()
    print(f"Se encontraron {len(orders)} órdenes")
else:
    print(f"Error: {response.status_code}")
    print(response.text)
```

> El resultado se verá así:

```json
[
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
          "name": "por enviar",
          "reasonID": null,
          "reasonName": null
        },
        "deliveryTrackId": null,
        "deliveryCarrierId": null,
        "deliveryCarrierName": null,
        "deliveryType": "dropshipping",
        "productType": "physical"
      },
      // Más productos...
    ]
  },
  // Más órdenes...
]
```

Este endpoint recupera todas las órdenes que coinciden con los criterios de filtrado especificados.

### Endpoint HTTP

`GET https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management`

### Parámetros de consulta

Parámetro | ¿Requerido? | Descripción
--------- | ----------- | -----------
email | No | Filtro por correo electrónico del cliente (clientData.email)
marketplace | No | Filtro por marketplace (Ej: T1)
orderid | No | Filtro por ID específico de orden
startDate | No | Fecha inicial para filtrar por rango de fechas (formato: YYYY-MM-DD)
endDate | No | Fecha final para filtrar por rango de fechas (formato: YYYY-MM-DD)
sellerId | No | Filtro por ID de vendedor (orderedProductsList.sellerId)

## Obtener una orden específica

```shell
curl "https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management/990_127000128_TestDev1" \
  -H "Authorization: Bearer API_KEY"
```

```javascript
const axios = require('axios');

const api = axios.create({
  baseURL: 'https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management',
  headers: {
    'Authorization': `Bearer ${API_KEY}`,
    'Content-Type': 'application/json'
  }
});

async function getOrder(orderId) {
  try {
    const response = await api.get(`/orders/${orderId}`);
    console.log(response.data);
    return response.data;
  } catch (error) {
    console.error('Error al obtener la orden:', error);
  }
}

getOrder('990_127000128_TestDev1');
```

```python
import requests

headers = {
    'Authorization': f'Bearer {API_KEY}',
    'Content-Type': 'application/json'
}

order_id = '990_127000128_TestDev1'
response = requests.get(f'https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management/{order_id}', headers=headers)

if response.status_code == 200:
    order = response.json()
    print(f"Orden encontrada: {order['orderid']}")
else:
    print(f"Error: {response.status_code}")
    print(response.text)
```

> El resultado se verá así:

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
      "sellerIdAxii": null,
      "pedidoIdAxii": null,
      "name": "Camisa De Vestir Niño Rosa Coral Manga Larga 3582 2-18 Años",
      "sku": "I22v4ufp3989",
      "IdFulfillment": null,
      "universal_id": null,
      "ImageLinkThumbnail": "http://img.ltwebstatic.com/images3_spmp/2024/01/04/f3/17043061112560de4bc5152f9d9d12deb18c6e4043_square.jpg",
      "salePrice": 329,
      "saleDiscount": 0,
      "totalSale": 329,
      "commission": 0,
      "commissionAmount": 0,
      "categoryNames": null,
      "categoryId": null,
      "colocationStatus": {
        "id": "1",
        "name": "por enviar",
        "reasonID": null,
        "reasonName": null
      },
      "deliveryTrackId": null,
      "deliveryCarrierId": null,
      "deliveryCarrierName": null,
      "deliveryType": "dropshipping",
      "productType": "physical",
      "deliveryBoardingDate": null,
      "estimatedDeliveryDate": null,
      "carrierDeliveryDate": null,
      "carrierPickUpDate": null,
      "actualDeliveryDate": null,
      "cancellationRequestDate": null,
      "repaymentDate": null,
      "ClickAndCollect": null,
      "dimensions": [
        {
          "height": 0,
          "width": 0,
          "depth": 0,
          "weight": 0
        }
      ],
      "statusInvoice": null,
      "statusTrack": null,
      "tipo_envio": "manual"
    },
    // Más productos...
  ]
}
```

Este endpoint recupera una orden específica por su ID.

### Endpoint HTTP

`GET https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management/:orderid`

### Parámetros URL

Parámetro | Descripción
--------- | -----------
orderid | ID único de la orden a recuperar

## Crear una nueva orden

```shell
curl "https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management" \
  -X POST \
  -H "Authorization: Bearer API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "clientData": {
      "email": "nuevo.cliente@ejemplo.com",
      "fullname": "Nuevo Cliente",
      "id": "nuevo.cliente@ejemplo.com"
    },
    "marketplace": "T1",
    "paymentData": {
      "bankAffiliation": "BBVA",
      "paymentInstallments": "MSI",
      "paymentNoInstallments": 1,
      "plan": "basic",
      "shippingCosts": 0,
      "subtotal": 998,
      "total": 998
    },
    "sellerID": "12028",
    "shippingAddress": {
      "borough": "Miguel Hidalgo",
      "city": "Ciudad de Mexico",
      "notes": "Edificio A",
      "outdoorNumber": "123",
      "phoneNumber": "5587654321",
      "state": "Ciudad de Mexico",
      "street": "Avenida Principal",
      "Suburb": "Polanco",
      "zipCode": "11560"
    },
    "orderedProductsList": [
      {
        "idProduct": 6078,
        "sellerId": 12028,
        "name": "Camisa De Vestir Niño Rosa Coral Manga Larga",
        "sku": "I22v4ufp3989",
        "salePrice": 329,
        "saleDiscount": 0,
        "totalSale": 329,
        "deliveryType": "dropshipping",
        "productType": "physical"
      },
      {
        "idProduct": 6077,
        "sellerId": 12028,
        "name": "Camisa De Vestir Niño Fiusha Manga Larga",
        "sku": "I32gtht9h8zo",
        "salePrice": 309,
        "saleDiscount": 0,
        "totalSale": 309,
        "deliveryType": "dropshipping",
        "productType": "physical"
      }
    ]
  }'
```

```javascript
const axios = require('axios');

const api = axios.create({
  baseURL: 'https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management',
  headers: {
    'Authorization': `Bearer ${API_KEY}`,
    'Content-Type': 'application/json'
  }
});

async function createOrder() {
  try {
    const orderData = {
      clientData: {
        email: "nuevo.cliente@ejemplo.com",
        fullname: "Nuevo Cliente",
        id: "nuevo.cliente@ejemplo.com"
      },
      marketplace: "T1",
      paymentData: {
        bankAffiliation: "BBVA",
        paymentInstallments: "MSI",
        paymentNoInstallments: 1,
        plan: "basic",
        shippingCosts: 0,
        subtotal: 998,
        total: 998
      },
      sellerID: "12028",
      shippingAddress: {
        borough: "Miguel Hidalgo",
        city: "Ciudad de Mexico",
        notes: "Edificio A",
        outdoorNumber: "123",
        phoneNumber: "5587654321",
        state: "Ciudad de Mexico",
        street: "Avenida Principal",
        Suburb: "Polanco",
        zipCode: "11560"
      },
      orderedProductsList: [
        {
          idProduct: 6078,
          sellerId: 12028,
          name: "Camisa De Vestir Niño Rosa Coral Manga Larga",
          sku: "I22v4ufp3989",
          salePrice: 329,
          saleDiscount: 0,
          totalSale: 329,
          deliveryType: "dropshipping",
          productType: "physical"
        },
        {
          idProduct: 6077,
          sellerId: 12028,
          name: "Camisa De Vestir Niño Fiusha Manga Larga",
          sku: "I32gtht9h8zo",
          salePrice: 309,
          saleDiscount: 0,
          totalSale: 309,
          deliveryType: "dropshipping",
          productType: "physical"
        }
      ]
    };
    
    const response = await api.post('/orders', orderData);
    console.log('Orden creada:', response.data);
    return response.data;
  } catch (error) {
    console.error('Error al crear la orden:', error);
  }
}

createOrder();
```

```python
import requests
import json

headers = {
    'Authorization': f'Bearer {API_KEY}',
    'Content-Type': 'application/json'
}

order_data = {
    "clientData": {
        "email": "nuevo.cliente@ejemplo.com",
        "fullname": "Nuevo Cliente",
        "id": "nuevo.cliente@ejemplo.com"
    },
    "marketplace": "T1",
    "paymentData": {
        "bankAffiliation": "BBVA",
        "paymentInstallments": "MSI",
        "paymentNoInstallments": 1,
        "plan": "basic",
        "shippingCosts": 0,
        "subtotal": 998,
        "total": 998
    },
    "sellerID": "12028",
    "shippingAddress": {
        "borough": "Miguel Hidalgo",
        "city": "Ciudad de Mexico",
        "notes": "Edificio A",
        "outdoorNumber": "123",
        "phoneNumber": "5587654321",
        "state": "Ciudad de Mexico",
        "street": "Avenida Principal",
        "Suburb": "Polanco",
        "zipCode": "11560"
    },
    "orderedProductsList": [
        {
            "idProduct": 6078,
            "sellerId": 12028,
            "name": "Camisa De Vestir Niño Rosa Coral Manga Larga",
            "sku": "I22v4ufp3989",
            "salePrice": 329,
            "saleDiscount": 0,
            "totalSale": 329,
            "deliveryType": "dropshipping",
            "productType": "physical"
        },
        {
            "idProduct": 6077,
            "sellerId": 12028,
            "name": "Camisa De Vestir Niño Fiusha Manga Larga",
            "sku": "I32gtht9h8zo",
            "salePrice": 309,
            "saleDiscount": 0,
            "totalSale": 309,
            "deliveryType": "dropshipping",
            "productType": "physical"
        }
    ]
}

response = requests.post(
    'https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management',
    headers=headers,
    data=json.dumps(order_data)
)

if response.status_code == 201:
    new_order = response.json()
    print(f"Orden creada con ID: {new_order['orderid']}")
else:
    print(f"Error: {response.status_code}")
    print(response.text)
```

> La respuesta se verá así:

```json
{
  "success": true,
  "message": "Orden creada exitosamente",
  "order": {
    "authorization_date": "2025-03-12 15:23:45",
    "clientData": {
      "email": "nuevo.cliente@ejemplo.com",
      "fullname": "Nuevo Cliente",
      "id": "nuevo.cliente@ejemplo.com"
    },
    "marketplace": "T1",
    "orderid": "990_127000129_T1",
    "paymentData": {
      "bankAffiliation": "BBVA",
      "paymentInstallments": "MSI",
      "paymentNoInstallments": 1,
      "paymentReference": "b2c1e4fe91175f48c33720acfffc126e",
      "plan": "basic",
      "shippingCosts": 0,
      "status": "pending",
      "subtotal": 998,
      "total": 998
    },
    "purchase_date": "2025-03-12 15:23:45",
    "sellerID": "12028",
    "shippingAddress": {
      "borough": "Miguel Hidalgo",
      "city": "Ciudad de Mexico",
      "notes": "Edificio A",
      "outdoorNumber": "123",
      "phoneNumber": "5587654321",
      "state": "Ciudad de Mexico",
      "street": "Avenida Principal",
      "Suburb": "Polanco",
      "zipCode": "11560"
    },
    "orderedProductsList": [
      {
        "colocationId": "1000004",
        "idProduct": 6078,
        "sellerId": 12028,
        "name": "Camisa De Vestir Niño Rosa Coral Manga Larga",
        "sku": "I22v4ufp3989",
        "salePrice": 329,
        "saleDiscount": 0,
        "totalSale": 329,
        "colocationStatus": {
          "id": "1",
          "name": "por enviar",
          "reasonID": null,
          "reasonName": null
        },
        "deliveryTrackId": null,
        "deliveryCarrierId": null,
        "deliveryType": "dropshipping",
        "productType": "physical"
      },
      {
        "colocationId": "1000005",
        "idProduct": 6077,
        "sellerId": 12028,
        "name": "Camisa De Vestir Niño Fiusha Manga Larga",
        "sku": "I32gtht9h8zo",
        "salePrice": 309,
        "saleDiscount": 0,
        "totalSale": 309,
        "colocationStatus": {
          "id": "1",
          "name": "por enviar",
          "reasonID": null,
          "reasonName": null
        },
        "deliveryTrackId": null,
        "deliveryCarrierId": null,
        "deliveryType": "dropshipping",
        "productType": "physical"
      }
    ]
  }
}
```

Este endpoint crea una nueva orden en el sistema.

### Endpoint HTTP

`POST https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management`

### Parámetros de la solicitud

Los parámetros deben enviarse como un objeto JSON en el cuerpo de la solicitud.

Parámetro | ¿Requerido? | Descripción
--------- | ----------- | -----------
clientData | Sí | Objeto con información del cliente
clientData.email | Sí | Correo electrónico del cliente
clientData.fullname | Sí | Nombre completo del cliente
clientData.id | Sí | Identificador del cliente (usualmente el email)
marketplace | Sí | Identificador del marketplace (Ej: T1)
paymentData | Sí | Objeto con información del pago
paymentData.bankAffiliation | No | Nombre del banco afiliado
paymentData.paymentInstallments | No | Tipo de pago en plazos (MSI, etc.)
paymentData.paymentNoInstallments | No | Número de plazos para el pago
paymentData.plan | No | Plan de compra (basic, middle, premium)
paymentData.shippingCosts | No | Costos de envío
paymentData.subtotal | Sí | Subtotal de la compra
paymentData.total | Sí | Total de la compra
sellerID | Sí | ID del vendedor principal
shippingAddress | Sí | Objeto con información de dirección de envío
shippingAddress.borough | Sí | Delegación/Municipio
shippingAddress.city | Sí | Ciudad
shippingAddress.notes | No | Notas adicionales
shippingAddress.outdoorNumber | Sí | Número exterior
shippingAddress.phoneNumber | Sí | Número telefónico
shippingAddress.state | Sí | Estado
shippingAddress.street | Sí | Calle
shippingAddress.Suburb | Sí | Colonia
shippingAddress.zipCode | Sí | Código postal
orderedProductsList | Sí | Array de productos ordenados
orderedProductsList[].idProduct | Sí | ID del producto
orderedProductsList[].sellerId | Sí | ID del vendedor del producto
orderedProductsList[].name | Sí | Nombre del producto
orderedProductsList[].sku | Sí | SKU del producto
orderedProductsList[].salePrice | Sí | Precio de venta
orderedProductsList[].saleDiscount | No | Descuento aplicado
orderedProductsList[].totalSale | Sí | Total de venta por producto
orderedProductsList[].deliveryType | Sí | Tipo de entrega (dropshipping, etc.)
orderedProductsList[].productType | Sí | Tipo de producto (physical, digital)

## Actualizar información de envío

```shell
curl "https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management/990_127000128_TestDev1/shipping/1000001" \
  -X PATCH \
  -H "Authorization: Bearer API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "deliveryTrackId": "GUR547890MX",
    "deliveryCarrierId": "DHL"
  }'
```

```javascript
const axios = require('axios');

const api = axios.create({
  baseURL: 'https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management',
  headers: {
    'Authorization': `Bearer ${API_KEY}`,
    'Content-Type': 'application/json'
  }
});

async function updateShippingInfo(orderId, colocationId, shippingInfo) {
  try {
    const response = await api.patch(
      `/orders/${orderId}/shipping/${colocationId}`,
      shippingInfo
    );
    console.log('Información de envío actualizada:', response.data);
    return response.data;
  } catch (error) {
    console.error('Error al actualizar información de envío:', error);
  }
}

updateShippingInfo(
  '990_127000128_TestDev1',
  '1000001',
  {
    deliveryTrackId: 'GUR547890MX',
    deliveryCarrierId: 'DHL'
  }
);
```

```python
import requests
import json

headers = {
    'Authorization': f'Bearer {API_KEY}',
    'Content-Type': 'application/json'
}

order_id = '990_127000128_TestDev1'
colocation_id = '1000001'
shipping_data = {
    "deliveryTrackId": "GUR547890MX",
    "deliveryCarrierId": "DHL"
}

response = requests.patch(
    f'https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management/{order_id}/shipping/{colocation_id}',
    headers=headers,
    data=json.dumps(shipping_data)
)

if response.status_code == 200:
    result = response.json()
    print(f"Información de envío actualizada para el producto {colocation_id}")
else:
    print(f"Error: {response.status_code}")
    print(response.text)
```

> La respuesta se verá así:

```json
{
  "success": true,
  "message": "Información de envío actualizada",
  "updatedProduct": {
    "colocationId": "1000001",
    "name": "Camisa De Vestir Niño Rosa Coral Manga Larga 3582 2-18 Años",
    "deliveryTrackId": "GUR547890MX",
    "deliveryCarrierId": "DHL",
    "deliveryCarrierName": "DHL",
    "deliveryType": "dropshipping",
    "colocationStatus": {
      "id": "1",
      "name": "por enviar"
    }
  }
}
```

Este endpoint actualiza la información de envío para un producto específico dentro de una orden.

### Endpoint HTTP

`PATCH https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management/:orderid/shipping/:colocationId`

### Parámetros URL

Parámetro | Descripción
--------- | -----------
orderid | ID único de la orden
colocationId | ID único del producto dentro de la orden

### Parámetros de la solicitud

Los parámetros deben enviarse como un objeto JSON en el cuerpo de la solicitud.

Parámetro | ¿Requerido? | Descripción
--------- | ----------- | -----------
deliveryTrackId | No | Número de guía para el envío
deliveryCarrierId | No | ID de la paquetería/transportista

## Actualizar estado de un producto

```shell
curl "https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management/990_127000128_TestDev

curl "https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management/990_127000128_TestDev1/status/1000001" \
  -X PATCH \
  -H "Authorization: Bearer API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "colocationStatus": {
      "id": "2",
      "name": "en tránsito"
    }
  }'
```

```javascript
const axios = require('axios');

const api = axios.create({
  baseURL: 'https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management',
  headers: {
    'Authorization': `Bearer ${API_KEY}`,
    'Content-Type': 'application/json'
  }
});

async function updateProductStatus(orderId, colocationId, statusInfo) {
  try {
    const response = await api.patch(
      `/orders/${orderId}/status/${colocationId}`,
      statusInfo
    );
    console.log('Estado del producto actualizado:', response.data);
    return response.data;
  } catch (error) {
    console.error('Error al actualizar el estado del producto:', error);
  }
}

updateProductStatus(
  '990_127000128_TestDev1',
  '1000001',
  {
    colocationStatus: {
      id: "2",
      name: "en tránsito"
    }
  }
);
```

```python
import requests
import json

headers = {
    'Authorization': f'Bearer {API_KEY}',
    'Content-Type': 'application/json'
}

order_id = '990_127000128_TestDev1'
colocation_id = '1000001'
status_data = {
    "colocationStatus": {
        "id": "2",
        "name": "en tránsito"
    }
}

response = requests.patch(
    f'https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management/{order_id}/status/{colocation_id}',
    headers=headers,
    data=json.dumps(status_data)
)

if response.status_code == 200:
    result = response.json()
    print(f"Estado actualizado para el producto {colocation_id}")
else:
    print(f"Error: {response.status_code}")
    print(response.text)
```

> La respuesta se verá así:

```json
{
  "success": true,
  "message": "Estado del producto actualizado",
  "updatedProduct": {
    "colocationId": "1000001",
    "idProduct": 6078,
    "name": "Camisa De Vestir Niño Rosa Coral Manga Larga 3582 2-18 Años",
    "colocationStatus": {
      "id": "2",
      "name": "en tránsito",
      "reasonID": null,
      "reasonName": null
    }
  }
}
```

Este endpoint actualiza el estado de un producto específico dentro de una orden.

### Endpoint HTTP

`PATCH https://4lviqvfon7.execute-api.us-east-2.amazonaws.com/prod/order_management/:orderid/status/:colocationId`

### Parámetros URL

Parámetro | Descripción
--------- | -----------
orderid | ID único de la orden
colocationId | ID único del producto dentro de la orden

### Parámetros de la solicitud

Los parámetros deben enviarse como un objeto JSON en el cuerpo de la solicitud.

Parámetro | ¿Requerido? | Descripción
--------- | ----------- | -----------
colocationStatus | Sí | Objeto con información del nuevo estado
colocationStatus.id | Sí | ID numérico del estado
colocationStatus.name | Sí | Nombre descriptivo del estado
colocationStatus.reasonID | No | ID de la razón del cambio de estado (si aplica)
colocationStatus.reasonName | No | Descripción de la razón del cambio de estado (si aplica)

# Estructura de Datos

A continuación se describen los principales componentes del objeto de orden.

## Orden Completa (Order)

Nombre del campo | Tipo | Descripción
---------------- | ---- | -----------
authorization_date | String | Fecha y hora de autorización del pedido (formato: YYYY-MM-DD HH:MM:SS)
clientData | Object | Información del cliente
marketplace | String | Identificador del marketplace de la orden
orderid | String | Identificador único de la orden
paymentData | Object | Información de pago de la orden
purchase_date | String | Fecha y hora de la compra (formato: YYYY-MM-DD HH:MM:SS)
sellerID | String | ID del vendedor principal
shippingAddress | Object | Información de la dirección de envío
orderedProductsList | Array | Lista de productos incluidos en la orden

## Datos del Cliente (clientData)

Nombre del campo | Tipo | Descripción
---------------- | ---- | -----------
email | String | Correo electrónico del cliente
fullname | String | Nombre completo del cliente
id | String | Identificador único del cliente (usualmente el email)

## Datos de Pago (paymentData)

Nombre del campo | Tipo | Descripción
---------------- | ---- | -----------
bank | String | Banco emisor (si aplica)
bankAffiliation | String | Banco afiliado para el procesamiento del pago
commissions | Object | Información de comisiones aplicadas
paymentDueDate | String | Fecha límite de pago (formato: YYYY-MM-DD HH:MM:SS)
paymentInstallments | String | Tipo de instalaciones de pago (MSI, etc.)
paymentNoInstallments | Number | Número de plazos para el pago
paymentReference | String | Referencia única del pago
plan | String | Plan seleccionado (básico, intermedio, premium)
shippingCosts | Number | Costos de envío
status | String | Estado del pago (done, pending, failed)
subtotal | Number | Subtotal de la orden (sin impuestos o envío)
total | Number | Total final de la orden

## Comisiones (commissions)

Nombre del campo | Tipo | Descripción
---------------- | ---- | -----------
gatewayFixed | Number | Comisión fija de la pasarela de pago
gatewaySurcharge | Number | Sobrecargo aplicado por la pasarela
gatewayVariable | Number | Comisión variable de la pasarela
t1paginas | Number | Comisión para T1 Páginas

## Dirección de Envío (shippingAddress)

Nombre del campo | Tipo | Descripción
---------------- | ---- | -----------
borough | String | Delegación o municipio
city | String | Ciudad
notes | String | Notas adicionales para la entrega
outdoorNumber | String | Número exterior
phoneNumber | String | Número telefónico de contacto
state | String | Estado
street | String | Calle
Suburb | String | Colonia
zipCode | String | Código postal

## Producto Ordenado (orderedProductsList item)

Nombre del campo | Tipo | Descripción
---------------- | ---- | -----------
colocationId | String | ID único del producto dentro de la orden
idProduct | Number | ID del producto en el catálogo
sellerId | Number | ID del vendedor del producto
sellerIdAxii | String/Null | ID del vendedor en el sistema Axii (si aplica)
pedidoIdAxii | String/Null | ID del pedido en el sistema Axii (si aplica)
name | String | Nombre completo del producto
sku | String | SKU único del producto
IdFulfillment | String/Null | ID de fulfillment (si aplica)
universal_id | String/Null | ID universal del producto (si aplica)
ImageLinkThumbnail | String | URL de la imagen en miniatura del producto
salePrice | Number | Precio de venta unitario
saleDiscount | Number | Descuento aplicado al producto
totalSale | Number | Total de venta por producto
commission | Number | Porcentaje de comisión aplicada
commissionAmount | Number | Monto de la comisión
categoryNames | String/Null | Nombres de categorías a las que pertenece el producto
categoryId | String/Null | ID de la categoría del producto
colocationStatus | Object | Estado actual del producto en el proceso de entrega
deliveryTrackId | String/Null | Número de guía para rastreo
deliveryCarrierId | String/Null | ID de la empresa de mensajería
deliveryCarrierName | String/Null | Nombre de la empresa de mensajería
deliveryType | String | Tipo de entrega (dropshipping, etc.)
productType | String | Tipo de producto (físico, digital)
deliveryBoardingDate | String/Null | Fecha de embarque
estimatedDeliveryDate | String/Null | Fecha estimada de entrega
carrierDeliveryDate | String/Null | Fecha de entrega reportada por la paquetería
carrierPickUpDate | String/Null | Fecha de recolección por la paquetería
actualDeliveryDate | String/Null | Fecha real de entrega al cliente
cancellationRequestDate | String/Null | Fecha de solicitud de cancelación (si aplica)
repaymentDate | String/Null | Fecha de reembolso (si aplica)
ClickAndCollect | Boolean/Null | Indica si es para recoger en tienda
dimensions | Array | Información dimensional del producto
statusInvoice | String/Null | Estado de facturación
statusTrack | String/Null | Estado de seguimiento
tipo_envio | String | Tipo de envío (manual, automático)

## Estado de Colocación (colocationStatus)

Nombre del campo | Tipo | Descripción
---------------- | ---- | -----------
id | String | ID del estado (1=por enviar, 2=en tránsito, 3=entregado, etc.)
name | String | Nombre descriptivo del estado
reasonID | String/Null | ID de la razón del estado (para casos especiales)
reasonName | String/Null | Descripción de la razón del estado

## Dimensiones (dimensions)

Nombre del campo | Tipo | Descripción
---------------- | ---- | -----------
height | Number | Altura del paquete en cm
width | Number | Ancho del paquete en cm
depth | Number | Profundidad del paquete en cm
weight | Number | Peso del paquete en kg

# Códigos de Error

La API utiliza los siguientes códigos de estado HTTP:

Código | Significado
------ | -----------
200 | OK -- La solicitud se ha completado correctamente
201 | Created -- El recurso se ha creado correctamente
400 | Bad Request -- La solicitud contiene sintaxis errónea o no puede procesarse
401 | Unauthorized -- No se ha proporcionado autenticación o es inválida
403 | Forbidden -- El servidor entendió la solicitud pero se niega a autorizarla
404 | Not Found -- El recurso solicitado no existe
405 | Method Not Allowed -- El método HTTP utilizado no es válido para este recurso
422 | Unprocessable Entity -- La solicitud está bien formada pero no se puede procesar debido a errores semánticos
429 | Too Many Requests -- Se han realizado demasiadas solicitudes en un período de tiempo
500 | Internal Server Error -- Error inesperado en el servidor
503 | Service Unavailable -- El servidor no está disponible temporalmente

## Formato de Error

```json
{
  "error": true,
  "code": "ERROR_CODE",
  "message": "Descripción detallada del error",
  "details": {
    "field": "campo específico con error",
    "reason": "razón específica del error"
  }
}
```

Ejemplo de respuesta para un error de validación:

```json
{
  "error": true,
  "code": "VALIDATION_ERROR",
  "message": "Los datos proporcionados no son válidos",
  "details": {
    "field": "paymentData.total",
    "reason": "El total debe ser mayor que cero"
  }
}
```