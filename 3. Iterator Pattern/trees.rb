tree =  ["A",
          ["B",
            ["D", nil, nil],
            nil
          ],
          ["C",
            ["E",
              ["G",
                ["I", nil, nil],
                ["J", nil, nil]
              ],
              ["H",
                nil,
                ["K", nil, nil]
              ]
            ],
            ["F", nil, nil]
          ]
       ]

class TreeTraversal

  def depth_first(root)
    Enumerator.new do |yielder|
      @yielder = yielder
      recursive_aux(root)
    end
  end

  def breadth_first(root)
    Enumerator.new do |yielder|
      queue = [root]
      while !queue.empty?
        x = queue.shift
        if !x.nil?
          queue.push(x[1])
          queue.push(x[2])
          yielder << x[0]
        end
      end
    end
  end

  private

  def recursive_aux(root)
    if !root.nil?
      @yielder << root[0]
      recursive_aux(root[1])
      recursive_aux(root[2])
    end
  end

end

tree_traversal = TreeTraversal.new
generator1 = tree_traversal.depth_first(tree)
generator2 = tree_traversal.breadth_first(tree)
p generator1.to_a
p generator2.to_a
