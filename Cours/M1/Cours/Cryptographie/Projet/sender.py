import socket
from cryptography.fernet import Fernet

# Create a socket for Alice
alice_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
alice_socket.bind(("127.0.0.1", 12345))
alice_socket.listen(1)

# Shared Key
encryption_key = b"XYj5224n7COUBWCJ0ybH4vfFXRF-J-Qk1XVW7BmfHFI="
cipher_suite = Fernet(encryption_key)

message = "Hello, Bob! This is a secret message from Alice."

# Wait for Bob to connect
print("Waiting for Bob to connect...")
bob_socket, _ = alice_socket.accept()
print("Bob connected!")

# Encrypt the message and send the message
encrypted_message = cipher_suite.encrypt(message.encode())

bob_socket.send(encrypted_message)

bob_socket.close()
alice_socket.close()
