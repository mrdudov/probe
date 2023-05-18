from decorators import plus_one, plus_n


@plus_one
def sum_v1(a: float, b: float) -> float:
    return a + b


@plus_n(n=10)
def sum_v2(a: float, b: float) -> float:
    return a + b


def main():
    print(f"{sum_v1(1, 2)=}")
    print(f"{sum_v2(1, 2)=}")


if __name__ == "__main__":
    main()
