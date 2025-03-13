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
