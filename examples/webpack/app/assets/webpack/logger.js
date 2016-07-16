class Logger {
  constructor(name) {
    this.name = name;
  }

  logit(val) {
    console.log(`Logged by ${this.name}: ${val}`);
  }
}

const myLogger = new Logger('First Logger');
const otherLogger = new Logger('Foo Logger');

myLogger.logit('hello world');
otherLogger.logit('hi!');
myLogger.logit('bye');
