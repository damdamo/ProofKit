
public class DynamicMatrix {

  private var data : [[Int]]

  public init(){
    data = [[0]]
  }

  public init(_ initial_data: [[Int]]){
    data = initial_data
    var columnNumber = 0
    for line in data {
      if line.count > columnNumber {
        columnNumber = line.count
      }
    }
    for i in 0...(data.count-1) {
      while data[i].count < columnNumber {
        data[i].append(0)
      }
    }
  }

  public func dim() -> (Int, Int){
    return (data.count, data[0].count)
  }

  private func add_lines(_ number:Int) -> () {
    guard number > 0 else {
      return
    }

    for _ in 1...number {
      data.append([])
      for _ in 1...data[0].count {
        data[data.count-1].append(0)
      }
    }
  }

  private func add_columns(_ number:Int) -> () {
    guard number > 0 else {
      return
    }

    for i in 0...(data.count-1) {
      for _ in 1...number {
        data[i].append(0)
      }
    }
  }

  private func verify_access_to(_ x:Int, _ y: Int) -> () {
    if x >= data.count {
      add_lines(x-data.count+1)
    }
    if y >= data[0].count {
      add_columns(y-data[0].count+1)
    }
  }

  subscript(x: Int, y: Int) -> Int {
    get {
      let safe_x = max(Int(0), x)
      let safe_y = max(Int(0), y)
      verify_access_to(safe_x, safe_y)
      return data[safe_x][safe_y]
    }

    set {
      let safe_x = max(Int(0), x)
      let safe_y = max(Int(0), y)
      verify_access_to(safe_x, safe_y)
      data[safe_x][safe_y] = newValue
    }
  }

  // = t_invariant with transposed matrix
  public func is_p_invariant(_ v: DynamicVector) -> Bool {
    let columnNumber = max(dim().0, v.size())

    for i in 1 ... dim().1 {
      var lineProduct = 0
      for j in 0 ... (columnNumber-1){
        lineProduct += self[(j, i)] * v[j]
      }
      if lineProduct != 0 {
        return false
      }
    }
    return true
  }

  public func is_t_invariant(_ v: DynamicVector) -> Bool {
    let columnNumber = max(dim().1, v.size())

    for i in 1 ... dim().0 {
      var lineProduct = 0
      for j in 0 ... (columnNumber-1){
        lineProduct += self[(j, i)] * v[j]
      }
      if lineProduct != 0 {
        return false
      }
    }
    return true
  }

  public func to_string() -> String {
    var result = "[\n"
    for line in data {
      result.append("\(line)\n")
    }
    result.append("]\n")

    return result
  }

}
