def getFibonacciNumber(index: int):
    a = 0
    b = 1
    for i in range(index):
        b = a+b
        a = b
        print("a: " + str(a) + " - b: " + str(a))
    return a

print(getFibonacciNumber(5))



