import socket

# Create a socket for Eve to intercept traffic
eve_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
eve_socket.bind(("127.0.0.1", 54321))
eve_socket.listen(1)

# Wait for Alice or Bob to connect (Eve intercepts)
print("Waiting for Alice or Bob to connect...")
intercepted_socket, _ = eve_socket.accept()
print("Connection intercepted!")

# Receive and print the intercepted message
intercepted_message = intercepted_socket.recv(1024)
print("Intercepted Message (Eve):", intercepted_message.decode())

# Close the socket
intercepted_socket.close()
