import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.naive_bayes import CategoricalNB
from sklearn.metrics import accuracy_score

file_path = 'Cardiovascular Disease Prediction - For model creation.csv'
data = pd.read_csv(file_path, delimiter=';')

# GEtting discrete values
discrete_columns = data.select_dtypes(include=['object', 'bool']).columns
discrete_data = data[discrete_columns]

# 80% and 20% percentage
train_data, test_data = train_test_split(discrete_data, test_size=0.2, random_state=42)

# Encoding
encoder = LabelEncoder()
for column in train_data.columns:
    train_data[column] = encoder.fit_transform(train_data[column])
    test_data[column] = encoder.transform(test_data[column])

# Separating values
X_train = train_data.drop('GOAL-Heart Disease', axis=1)
y_train = train_data['GOAL-Heart Disease']
X_test = test_data.drop('GOAL-Heart Disease', axis=1)
y_test = test_data['GOAL-Heart Disease']

# Training classifieur Naive Bayes
model = CategoricalNB()
model.fit(X_train, y_train)

# Evaluate the model
predictions = model.predict(X_test)
score = accuracy_score(y_test, predictions)

print(f"Score : {score}")