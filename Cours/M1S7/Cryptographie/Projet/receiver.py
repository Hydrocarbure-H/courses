import socket
from cryptography.fernet import Fernet

# Create a socket for Bob
bob_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
bob_socket.connect(("127.0.0.1", 12345))

# Encryption key shared with Alice
encryption_key = b"XYj5224n7COUBWCJ0ybH4vfFXRF-J-Qk1XVW7BmfHFI="

cipher_suite = Fernet(encryption_key)

# Receive the encrypted message from Alice
encrypted_message = bob_socket.recv(1024)

# Decrypt the message
decrypted_message = cipher_suite.decrypt(encrypted_message)
print("Received Message (Bob):", decrypted_message.decode())

bob_socket.close()
