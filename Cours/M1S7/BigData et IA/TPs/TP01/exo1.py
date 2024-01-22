import random
import numpy as np

W = (0,0)
b = 0.5
alpha = 0.1

def generate_class1(n):
    """
    Generates n points in the first class, abscisse in [0,10] and ordonnée in [0,10]
    """
    points = []
    for i in range(n):
        x = int(random.random()*10)
        y = int(random.random()*10)
        points.append((x,y,0))
    return points


def generate_class2(n):
    """
    Generates n points in the second class, abscisse in [-10,0] and ordonnée in [0,10]
    """
    points = []
    for i in range(n):
        x = int(random.random()*(-10))
        y = int(random.random()*10)
        points.append((x,y,1))
    return points


def get_points(n):
    """
    Generates n points for the training dataset
    """
    points = []
    points += generate_class1(n)
    points += generate_class2(n)
    
    random.shuffle(points)

    return points


def dataset_entrainement_f(points):
    """
    Generates n points for the training dataset
    """

    # Get 80% of the points
    points = points[:int(len(points)*0.8)]
    return points


def dataset_test_f(points):
    """
    Generates n points for the testing dataset
    """

    # Get 20% of the points
    points = points[int(len(points)*0.8):]
    return points


def f(x,y):
    """
    Returns the value of the function f(x,y) = W_0 * x + W_1 * y + b
    """
    return W[0]*x + W[1]*y + b


# Test the model
def test_model(dataset):
    """
    Returns the accuracy of the model
    """
    correct_predictions = 0
    for e in dataset:
        x = e[0]
        y = e[1]
        label = e[2]

        if f(x,y) > 0:
            prediction = 1
        else:
            prediction = 0

        if prediction == label:
            correct_predictions += 1

    return correct_predictions / len(dataset)


def sigmoid(x):
    """"
    Returns the sigmoid of x
    """
    return 1 / (1 + np.exp(-x))


def f2(x,y):
    """
    Returns the value of the function f(x,y) = sigmoid(W_0 * x + W_1 * y + b)
    """
    return sigmoid(W[0]*x + W[1]*y + b)


def test_model2(dataset):
    """
    Returns the accuracy of the model
    """
    correct_predictions = 0
    for e in dataset:
        x = e[0]
        y = e[1]
        label = e[2]

        if f2(x,y) > 0.5:
            prediction = 1
        else:
            prediction = 0

        if prediction == label:
            correct_predictions += 1

    return correct_predictions / len(dataset)



points = get_points(1000000)
dataset_entrainement = dataset_entrainement_f(points)
dataset_test = dataset_test_f(points)

# Formule W_0 * x + W_1 * y + b

for e in dataset_entrainement:
    x = e[0]
    y = e[1]
    label = e[2]

    if f(x,y) > 0:
        prediction = 1
    else:
        prediction = 0

    if prediction != label:
        w0 = W[0] + alpha * (label - prediction) * x 
        w1 = W[1] + alpha * (label - prediction) * y
        b = b + alpha * (label - prediction)
        W = (w0,w1)

print("W = ", W)

print("b = ", b)

print("Accuracy of the model : ", test_model(dataset_test))

print("Accuracy of the model with sigmoid : ", test_model2(dataset_test))
