import random

from faker import Faker
from faker_vehicle import VehicleProvider

fake = Faker()
fake.add_provider(VehicleProvider)

count = 1000
result = []
sql_file_name = 'car.sql'

db_create_script = """
CREATE TABLE car (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    price NUMERIC(19, 2) NOT NULL
);
"""

preffix = 'INSERT INTO car (make, model, price) '

for _ in range(count):
    make = fake.vehicle_make().replace("'", "''")
    model = fake.vehicle_model().replace("'", "''")
    price = round(10_000 + random.random()*(10**random.randint(1,5)),2)

    result.append(
        preffix + f"""VALUES ('{make}', '{model}', '{price}');\n"""
    )


with open(sql_file_name, 'w') as file:
    file.write(db_create_script)
    file.write(''.join(result))
