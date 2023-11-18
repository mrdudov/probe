from sqlalchemy import create_engine, text


engine = create_engine("sqlite+pysqlite:///:memory:", echo=True, future=True)


with engine.connect() as connection:
    result = connection.execute(text("select 'hello world'"))
    print(result.all())


with engine.connect() as connection:
    connection.execute(text("CREATE TABLE some_table (x int, y int)"))
    connection.execute(
        text("INSERT INTO some_table (x, y) VALUES (:x, :y)"),
        [{"x": 1, "y": 1}, {"x": 2, "y": 4}],
    )
    connection.commit()


with engine.begin() as connection:
    connection.execute(
        text("INSERT INTO some_table (x, y) VALUES (:x, :y)"),
        [{"x": 6, "y": 8}, {"x": 9, "y": 10}],
    )


with engine.connect() as connection:
    result = connection.execute(text("SELECT x, y FROM some_table"))
    for row in result:
        # print(row)
        print(f"x:{row.x}  y:{row.y}")
