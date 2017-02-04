# fronzen_string_literals: true

require 'minitest/autorun'
require_relative 'plotter'

class PloterTest < Minitest::Test
  Plotable = Struct.new(:label, :children) do
    def initialize(*)
      super
      self.children ||= []
    end
  end

  def test_plot_single_item
    item = Plotable.new('Item label', [])

    assert_equal "Item label\n", Plotter.plot_tree(item)
  end

  def test_plot_single_child
    child = Plotable.new('Child label')
    parent = Plotable.new('Parent label', [child])

    plot_result = <<~TREE
      Parent label
      └─ Child label
    TREE
    assert_equal plot_result, Plotter.plot_tree(parent)
  end

  def test_plot_multiple_children
    child1 = Plotable.new('Child label 1')
    child2 = Plotable.new('Child label 2')
    child3 = Plotable.new('Child label 3')
    parent = Plotable.new('Parent label', [child1, child2, child3])

    plot_result = <<~TREE
      Parent label
      ├─ Child label 1
      ├─ Child label 2
      └─ Child label 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(parent)
  end

  def test_plot_granchild
    granchild = Plotable.new('Granchild label')
    child = Plotable.new('Child label', [granchild])
    parent = Plotable.new('Parent label', [child])

    plot_result = <<~TREE
      Parent label
      └─ Child label
         └─ Granchild label
    TREE
    assert_equal plot_result, Plotter.plot_tree(parent)
  end

  def test_plot_multiple_granchildren
    granchild1 = Plotable.new('Granchild label 1')
    granchild2 = Plotable.new('Granchild label 2')
    granchild3 = Plotable.new('Granchild label 3')
    child = Plotable.new('Child label', [granchild1, granchild2, granchild3])
    parent = Plotable.new('Parent label', [child])

    plot_result = <<~TREE
      Parent label
      └─ Child label
         ├─ Granchild label 1
         ├─ Granchild label 2
         └─ Granchild label 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(parent)
  end

  def test_plot_multiple_children_and_granchildren
    granchild1 = Plotable.new('Granchild label 1')
    granchild2 = Plotable.new('Granchild label 2')
    granchild3 = Plotable.new('Granchild label 3')
    child1 = Plotable.new('Child label 1', [granchild1, granchild2, granchild3])
    child2 = Plotable.new('Child label 2', [granchild1, granchild2, granchild3])
    parent = Plotable.new('Parent label', [child1, child2])

    plot_result = <<~TREE
      Parent label
      ├─ Child label 1
      │  ├─ Granchild label 1
      │  ├─ Granchild label 2
      │  └─ Granchild label 3
      └─ Child label 2
         ├─ Granchild label 1
         ├─ Granchild label 2
         └─ Granchild label 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(parent)
  end
end
