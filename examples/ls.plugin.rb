#^ls\b
before { |line|
  p line.upcase
  line
}
after { |out, err, line|
  require 'colorist'
  require 'rainbow'
  [out.color("#ff0000"), err, line]
}
