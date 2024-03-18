const array = [4, 5, 6];
const set = new Set([4, 5, 6]);

const object = { a: 4, b: 5, c: 6 };
const map = new Map(Object.entries({ a: 4, b: 5, c: 6 }));

function testLoops(data) {
  console.log('Testing:', data)

  console.log('for..in');
  for (const k in data) {
    console.log(k);
  }

  console.log('for..of');
  try {
    for (const v of data) {
      console.log(v);
    }
  } catch (e) {
    console.log('Unable to run for..of: ', e)
  }

  console.log('\n')
}

testLoops(array);
testLoops(set);
testLoops(object);
testLoops(map);
