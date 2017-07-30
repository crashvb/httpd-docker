# You are seeing this source because you have attempted to access /hello/hello.py; try using /hellopy instead ;)

def application(environ,start_response):
 output="<html>\n  <head><title>Hello: Python</title></head>\n  <body><p>Hello Python World!</p></body>\n</html>"
 status='200 OK'
 response_headers=[('Content-type','text/html'),
 ('Content-Length',str(len(output)))]
 start_response(status,response_headers)
 return [output]
