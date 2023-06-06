export { Car }

class Car {
  constructor(color, power, model) {
    this.model = model
    this.power = power
    this.color = color
  }

  run() {
    console.log(`${this.model} is run!`)
  }

  chip_tuning(increase_power) {
    if (increase_power < 350) {
      this.power += increase_power
    } else {
      console.log("Engine is burn!")
    }
  }

  print() {
    console.log(
      `Car model is ${this.model}, color: ${this.color}, power: ${this.power}`
    )
  }
}
