# Plotter

This is a simple ruby algorithm that plots a tree based in a Hash.

Example:
```ruby
tree = {
  label: 'Parent label',
  children: [
    { label: 'Child label 1', children: [] },
    { label: 'Child label 2', children: [] },
    { label: 'Child label 3', children: [] }
  ]
}

Plotter.plot_tree(tree)
# =>
# Parent label
# ├─ Child label 1
# ├─ Child label 2
# └─ Child label 3
```

It supports more levels of nesting and adds a connectiong line between siblings:
```
Parent label
├─ Child label 1
│  ├─ Granchild label 1
│  │  ├─ Grangranchild label 1
│  │  └─ Grangranchild label 2
│  ├─ Granchild label 2
│  └─ Granchild label 3
└─ Child label 2
   ├─ Granchild label 1
   │  ├─ Grangranchild label 1
   │  └─ Grangranchild label 2
   ├─ Granchild label 2
   └─ Granchild label 3
```

## Running the tests
```shell
ruby plotter_test.rb
```

## TODO:
* Allow 'chilren' node to have `nil` value
* Add documentation
* Improve class / module names (`Plotter` is too generic)
