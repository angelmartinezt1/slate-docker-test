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
